<script>
import Header from "./components/Header.vue";
import HeaderUsser from "./components/HeaderUsser.vue";
import { computed } from 'vue';
import { useUserStore } from "./store/auth.js";

export default {
  components: {
    Header,
    HeaderUsser,
  },
  setup() {
    const userStore = useUserStore();

    // Sử dụng computed để kiểm tra vai trò của người dùng
    const IsUser = computed(() => {
      const user = userStore.getUser; // Lấy người dùng hiện tại
      return user && user.role === 'user'; // Kiểm tra role nếu user tồn tại
    });
    const IsNotUser = computed(() => {
      const user = userStore.getUser; // Lấy người dùng hiện tại
      return user && user.role !== 'user'; // Kiểm tra role nếu user tồn tại
    });

    // Tạo một computed để quản lý lớp điều kiện
    const containerClass = computed(() => {
      return IsUser.value ? '' : 'flex';
    });

    return {
      IsUser,
      IsNotUser,
      containerClass,
    };
  }
};
</script>

<template>
  <div :class="['w-full min-h-screen font-sans text-gray-900 bg-gray-50', containerClass]">
    <HeaderUsser v-if="IsUser" />
    <Header v-if="IsNotUser" />
    <router-view></router-view>
  </div>
</template>
