<template>
  <div class="splash" :style="{ width: width + 'px', height: height + 'px' }">
    <button @click="onClick">Start Game</button>
  </div>
</template>

<script>
export default {
  props: {
    width: {
      type: Number,
      required: true,
    },
    height: {
      type: Number,
      required: true,
    },
  },
};
</script>

<style scoped lang="scss">
.splash {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  background-color: #00a;
  button {
    cursor: pointer;
    user-select: none;
  }
}
</style>
