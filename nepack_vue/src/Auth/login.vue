<template>
  <div class="mx-auto md:ml-64 lg:mx-auto py-28">
    <div class="flex justify-center">
      <div class="w-[100%] md:w-[600px]">  
        <form
          @submit.prevent="login"
          class="p-8 border border-gray-300 shadow-md rounded-lg relative"
          v-if="!user"
        >
          <h1 class="text-center mb-4 text-2xl font-semibold tracking-wide">
            LOGIN
          </h1>
          <div v-if="errors" class="w-[100%] bg-red-400 text-white rounded-md p-2">
                  {{ errors }}

          </div>
          <div class="">
            <label for="email" class="input">Your email</label>
            <input
              type="email"
              id="email"
              class="input2"
              placeholder="nepack2002@gmail.com"
              v-model="email"
            />
          </div>
           <!-- Hiển thị lỗi email -->
            <div v-if="error.email" class="text-red-500">
              <ul>
                <li>{{ error.email }}</li>
              </ul>
            </div>
          <div class="">
            <div class="flex justify-between items-center">
              <label for="password" class="input">Password</label>
              <router-link :to="{ name: 'ForgotPassword' }" class="text-sm font-medium hover:underline"
                >Forgot password?
              </router-link>
            </div>
            <input
              type="password"
              id="password"
              placeholder="123"
              class="input2"
              v-model="password"
            />
          </div>
          <div v-if="error.password" class="text-red-500">
              <ul>
                <li>{{ error.password }}</li>
              </ul>
            </div>
          <div class="grid pt-7">
            <button
              type="submit"
              class="bg-gray-600 hover:bg-gray-500 text-white font-medium py-2 px-4 rounded"
              name="login"
            >
              SIGN IN
            </button>
          </div>
          <div class="text-center mt-3">
            <a class="text-black-50 cursor-pointer hover:underline"
              >Create account</a
            >
          </div>
        </form>
      </div>
    </div>
  </div>
</template>

<script>
import { ref, computed, onMounted } from "vue";
import { useRouter } from "vue-router";
import { useUserStore } from "../store/auth.js";

export default {
    setup() {
    const router = useRouter();
    const userStore = useUserStore();
    const email = ref("");
    const password = ref("");
    // const isFetchingUser = ref(true);
    const login = async () => {
      try {
          await userStore.login(email.value, password.value);
         if (user.value) {
            router.push("/cars");
      }
      } catch (error) {
        console.log("lỗi");
      }
    };
    const logout = async () => {
      await userStore.logout();
    };

    const token = computed(() => userStore.getToken);
    const user = computed(() => userStore.getUser);
    const error = computed(() => userStore.getErrorMessage);
    const errors = computed(() => userStore.getError);
        onMounted(async () => {
            await userStore.fetchUser();
    });

    return {
      email,
      password,
      login,
      logout,
      token,
      user,
      error,
      errors,
      // isFetchingUser
    };
  }
};
</script>
