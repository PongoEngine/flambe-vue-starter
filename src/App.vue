<template>
  <div id="app">
    <component
      class="ui"
      v-if="ui"
      :is="ui.def"
      v-bind="uiprops"
      :style="{ width: gameWidth + 'px' }"
    />
    <canvas ref="canvas" />
  </div>
</template>

<script>
export default {
  name: "App",
  data() {
    return {
      gameWidth: 514,
      gameHeight: 696,
      stack: [],
    };
  },
  computed: {
    ui() {
      const last = this.stack.length - 1;
      return this.stack[last];
    },
    uiprops() {
      return { ...this.ui.props };
    },
  },
  mounted() {
    window.flambe = {
      canvas: this.$refs.canvas,
    };
    const flambe = require("../build.hxml");
    this.stack = flambe.flambe.System.get_web().stack;
    window.addEventListener("resize", this.layoutScale);
    this.layoutScale();
    flambe.game.Main.start(this.gameWidth, this.gameHeight);
  },
  beforeDestroy() {
    window.removeEventListener("resize", this.layoutScale);
  },
  methods: {
    layoutScale() {
      const containerWidth = window.innerWidth;
      const containerHeight = window.innerHeight;

      const imgRatio = this.gameHeight / this.gameWidth; // original img ratio
      const containerRatio = containerHeight / containerWidth; // container ratio

      let finalWidth = 0.0; // the scaled img width
      let finalHeight = 0.0;

      if (containerRatio < imgRatio) {
        finalHeight = containerHeight;
        finalWidth = containerHeight / imgRatio;
      } else {
        finalWidth = containerWidth;
        finalHeight = containerWidth * imgRatio;
      }

      const gameScale = finalWidth / this.gameWidth;
      const offsetX = (containerWidth - finalWidth) / 2;
      const offsetY = (containerHeight - finalHeight) / 2;

      document.documentElement.style.setProperty("--layout-scale", gameScale);
      document.documentElement.style.setProperty("--layout-x", offsetX + "px");
      document.documentElement.style.setProperty("--layout-y", offsetY + "px");
    },
  },
};
</script>

<style lang="scss">
#app,
html,
body {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  margin: 0;
  width: 100%;
  height: 100%;
  overflow: hidden;
}
.ui {
  position: absolute;
  top: var(--layout-y);
  left: var(--layout-x);
  transform: scale(var(--layout-scale));
  transform-origin: 0 0;
  background-color: rgba(0, 0, 255, 0.5);
}
canvas {
  display: block;
  width: 100%;
  height: 100%;
}
#app {
  width: 100%;
  height: 100%;
}
</style>
