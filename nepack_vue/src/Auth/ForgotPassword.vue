<template>
  <div class="mx-auto md:ml-64 lg:mx-auto py-28">
    <div class="bg-white shadow-lg rounded-lg p-8 w-[100%] md:w-[600px]">
      <h2 class="text-2xl font-semibold text-center mb-6">Forgot Password</h2>
      <form method="POST" @submit.prevent="submit">
        <div class="mb-4">
          <label for="email" class="block text-gray-700 font-medium mb-2">Email:</label>
          <input
            type="email"
            v-model="email"
            class="w-full border rounded px-3 py-2 focus:outline-none focus:border-indigo-500"
            required
          />
        </div>
        <button
          type="submit"
          class="w-full bg-indigo-600 text-white py-2 rounded hover:bg-indigo-700 transition"
          :disabled="loading"
        >
          <!-- Hiển thị văn bản hoặc loading spinner -->
          <span v-if="loading">Sending...</span>
          <span v-else>Send Password Reset Link</span>
        </button>
      </form>
      <div v-if="success" class="mt-4 text-green-500 text-center">
        An email with a password reset link has been sent to your email.
      </div>
      <div class="mt-4 text-center">
        <router-link
          :to="{ name: 'Login' }"
          class="text-indigo-600 hover:text-indigo-800 transition"
        >
          Back to Login
        </router-link>
      </div>
    </div>
  </div>
</template>

<script>
import axios from "axios";
import { ref } from "vue";

export default {
  setup() {
    const email = ref('');
    const loading = ref(false); // Trạng thái loading
    const success = ref(false); // Trạng thái thành công

    const submit = async () => {
      loading.value = true; // Bắt đầu trạng thái loading
      success.value = false; // Đặt lại trạng thái thành công
      try {
        // Gửi yêu cầu
        await axios.post("http://127.0.0.1:8000/api/forgotPassword", {
          email: email.value,
        });

        // Xử lý khi gửi email thành công
        success.value = true;
        console.log('Email sent successfully');
      } catch (e) {
        console.error(e);
        // Bạn có thể xử lý lỗi tại đây
      } finally {
        loading.value = false; // Kết thúc trạng thái loading
      }
    };

    return { submit, email, loading, success };
  },
};
</script>
