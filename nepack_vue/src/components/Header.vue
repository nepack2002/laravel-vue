<template>
  <button
    id="toggle-top-menu-icon"
    @click="toggleSidebar"
    type="button"
    class="inline-flex p-2 mt-2 ms-3 text-sm text-gray-500 rounded-lg md:hidden dark:text-gray-400"
    aria-label="Toggle Sidebar"
  >
    <svg
      class="w-6 h-6"
      fill="currentColor"
      viewBox="0 0 20 20"
      xmlns="http://www.w3.org/2000/svg"
    >
      <path
        d="M2 4.75A.75.75 0 012.75 4h14.5a.75.75 0 010 1.5H2.75A.75.75 0 012 4.75zm0 10.5a.75.75 0 01.75-.75h7.5a.75.75 0 010 1.5h-7.5a.75.75 0 01-.75-.75zM2 10a.75.75 0 01.75-.75h14.5a.75.75 0 010 1.5H2.75A.75.75 0 012 10z"
      />
    </svg>
  </button>
  <aside
    id="tqd-top-menu"
    :class="[
      'fixed top-0 left-0 z-40 w-64 h-screen transition-transform md:translate-x-0 border-r border-gray-200 px-4',
      showSidebar ? 'translate-x-0 bg-slate-50' : '-translate-x-full',
    ]"
    aria-label="Sidebar"
  >
    <div class="h-full px-3 py-4 overflow-y-auto">
      <a href="https://flowbite.com/" class="flex items-center ps-2.5 mb-5">
        <img
          src="https://flowbite.com/docs/images/logo.svg"
          class="h-6 me-3 sm:h-7"
          alt="Flowbite Logo"
        />
        <span class="self-center text-xl font-semibold whitespace-nowrap"
          >Nepack</span
        >
         <div>
        <!-- <p>User: {{ user.role }}</p> -->
    </div>
      </a>
      <ul class="space-y-2 font-medium mt-[60px]">
        <li
          v-for="(item, index) in menuItems"
          :key="index"
          @click="selectMenuItem(index)"
          :class="{ 'bg-gray-300 ml-5': activeIndex === index }"
          class="py-2 pl-2 rounded-md hover:bg-gray-300"
        >
          <router-link :to="item.route" class="flex">
            <div v-html="item.icon" class="menu-icon"></div>
            <span class="flex-1 ms-3 whitespace-nowrap">{{ item.name }}</span>
          </router-link>
        </li>
        <div class="fixed bottom-10 w-[80%] cursor-pointer">
          <li v-if="isLoggedIn">
            <span @click="logout" class="header-a group">
              <svg
                class="header-svg"
                aria-hidden="true"
                xmlns="http://www.w3.org/2000/svg"
                fill="none"
                viewBox="0 0 18 16"
              >
                <path
                  stroke="currentColor"
                  stroke-linecap="round"
                  stroke-linejoin="round"
                  stroke-width="2"
                  d="M1 8h11m0 0L8 4m4 4-4 4m4-11h3a2 2 0 0 1 2 2v10a2 2 0 0 1-2 2h-3"
                />
              </svg>
              <span class="flex-1 ms-3 whitespace-nowrap">Log out</span>
            </span>
          </li>
          <li v-else>
            <router-link to="/login" class="header-a group">
              <svg
                class="header-svg"
                aria-hidden="true"
                xmlns="http://www.w3.org/2000/svg"
                fill="none"
                viewBox="0 0 18 16"
              >
                <path
                  stroke="currentColor"
                  stroke-linecap="round"
                  stroke-linejoin="round"
                  stroke-width="2"
                  d="M1 8h11m0 0L8 4m4 4-4 4m4-11h3a2 2 0 0 1 2 2v10a2 2 0 0 1-2 2h-3"
                />
              </svg>

              <span class="flex-1 ms-3 whitespace-nowrap">Sign In</span>
            </router-link>
          </li>
        </div>
      </ul>
    </div>
  </aside>
</template>






<script setup>
import { ref, computed, onMounted, onBeforeUnmount } from "vue";
import { useRouter } from "vue-router";
import { useUserStore } from "../store/auth.js";

const router = useRouter();
const userStore = useUserStore();
 const token = computed(() => userStore.getToken);
      //   const user = computed(() => userStore.getUser);
const user = computed(() => userStore.getUser);
const isLoggedIn = computed(() => !!user.value);

// Trạng thái hiển thị của sidebar
const showSidebar = ref(false);
// Trạng thái active của mục trong sidebar
const activeIndex = ref(null);

// Hàm để chuyển đổi trạng thái của sidebar
const toggleSidebar = () => {
  showSidebar.value = !showSidebar.value;
};

// Hàm đăng xuất
const logout = async () => {
  await userStore.logout();
  router.push("/login");
};

// Hàm xử lý sự kiện nhấp chuột để ẩn sidebar nếu nhấp ra ngoài
const handleClickOutside = (event) => {
  const sidebarElement = document.getElementById("tqd-top-menu");
  const toggleButton = document.getElementById("toggle-top-menu-icon");

  // Kiểm tra nếu người dùng nhấp ra ngoài sidebar và không nhấp vào nút chuyển đổi
  if (
    showSidebar.value &&
    !sidebarElement.contains(event.target) &&
    !toggleButton.contains(event.target)
  ) {
    showSidebar.value = false;
  }
};
// Hàm chọn một mục trong sidebar
const selectMenuItem = (index) => {
  activeIndex.value = index;
};
const menuItems = [
  {
    name: "Dashboard",
    route: "/",
    icon: `<svg class="header-svg" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="currentColor" viewBox="0 0 22 21">
                  <path d="M16.975 11H10V4.025a1 1 0 0 0-1.066-.998 8.5 8.5 0 1 0 9.039 9.039.999.999 0 0 0-1-1.066h.002Z"/>
                  <path d="M12.5 0c-.157 0-.311.01-.565.027A1 1 0 0 0 11 1.02V10h8.975a1 1 0 0 0 1-.935c.013-.188.028-.374.028-.565A8.51 8.51 0 0 0 12.5 0Z"/>
               </svg>`,
  },
  {
    name: "Users",
    route: "/users",
    icon: `<svg class="header-svg" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="currentColor" viewBox="0 0 20 18">
                  <path d="M14 2a3.963 3.963 0 0 0-1.4.267 6.439 6.439 0 0 1-1.331 6.638A4 4 0 1 0 14 2Zm1 9h-1.264A6.957 6.957 0 0 1 15 15v2a2.97 2.97 0 0 1-.184 1H19a1 1 0 0 0 1-1v-1a5.006 5.006 0 0 0-5-5ZM6.5 9a4.5 4.5 0 1 0 0-9 4.5 4.5 0 0 0 0 9ZM8 10H5a5.006 5.006 0 0 0-5 5v2a1 1 0 0 0 1 1h11a1 1 0 0 0 1-1v-2a5.006 5.006 0 0 0-5-5Z"/>
               </svg>
`,
  },
  {
    name: "Cars",
    route: "/cars",
    icon: `<svg class="header-svg" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="currentColor" viewBox="0 0 18 20">
                  <path d="M17 5.923A1 1 0 0 0 16 5h-3V4a4 4 0 1 0-8 0v1H2a1 1 0 0 0-1 .923L.086 17.846A2 2 0 0 0 2.08 20h13.84a2 2 0 0 0 1.994-2.153L17 5.923ZM7 9a1 1 0 0 1-2 0V7h2v2Zm0-5a2 2 0 1 1 4 0v1H7V4Zm6 5a1 1 0 1 1-2 0V7h2v2Z"/>
               </svg>
`,
  },
  {
    name: "Departments",
    route: "/department",
    icon: `<svg class="header-svg" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="currentColor" viewBox="0 0 18 20">
                  <path d="M17 5.923A1 1 0 0 0 16 5h-3V4a4 4 0 1 0-8 0v1H2a1 1 0 0 0-1 .923L.086 17.846A2 2 0 0 0 2.08 20h13.84a2 2 0 0 0 1.994-2.153L17 5.923ZM7 9a1 1 0 0 1-2 0V7h2v2Zm0-5a2 2 0 1 1 4 0v1H7V4Zm6 5a1 1 0 1 1-2 0V7h2v2Z"/>
               </svg>
`,
  },
];
onMounted(async () => {
//   await userStore.fetchUser();

  // Đăng ký sự kiện nhấp chuột để xử lý ẩn sidebar khi nhấp ra ngoài
  document.addEventListener("click", handleClickOutside);
});

// Hủy bỏ sự kiện nhấp chuột khi component bị hủy để tránh rò rỉ bộ nhớ
onBeforeUnmount(() => {
  document.removeEventListener("click", handleClickOutside);
});
</script>
