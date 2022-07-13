<template>
  <p class="hello" @click="onClick">{{ name }}!</p>
</template>

<script>
export default {
  props: {
    name: {
      type: String,
      required: true,
    },
  },
};
</script>

<style scoped lang="scss">
p {
  margin: 0;
  cursor: pointer;
  user-select: none;
  color: #fff;
  font-weight: 700;
  font-family:Arial, Helvetica, sans-serif;
  font-size: 20px;
}
</style>
