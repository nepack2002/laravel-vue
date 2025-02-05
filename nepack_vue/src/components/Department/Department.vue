<script>
import { defineComponent, ref, onMounted, watch } from "vue";
import axios from "axios";
import { useUserStore } from "../../store/auth.js";

export default defineComponent({
  setup() {
    const userStore = useUserStore();
    const departments = ref([]);
    const currentPage = ref(1); // Trang hiện tại
    const totalPages = ref(0); // Tổng số trang
    const showDeleteSuccess = ref(false);
    const searchQuery = ref("");
    // Hàm để lấy danh sách phong ban với phân trang
    const fetchDepartments = async (page = 1) => {
      try {
        const response = await axios.get(
          `http://127.0.0.1:8000/api/departments?page=${page}&query=${searchQuery.value}`,
          {
            headers: {
              Authorization: `Bearer ${userStore.token}`,
            },
          }
        );

        // Lưu trữ dữ liệu trả về và thông tin phân trang
        departments.value = response.data.data;
        currentPage.value = response.data.current_page;
        totalPages.value = response.data.last_page;
        if (departments.value.length === 0 && currentPage.value > 1) {
          // Nếu không còn người dùng trên trang hiện tại và không phải là trang đầu tiên
          // Chuyển về trang trước đó
          currentPage.value -= 1;
          console.log("hết");
          await fetchDepartments(currentPage.value);
        }
      } catch (error) {
        console.error("Error fetching users:", error);
      }
    };
    // Khi giá trị của searchQuery thay đổi, gọi fetchUsers
    watch(searchQuery, () => {
      fetchDepartments(currentPage.value);
    });

    // Gọi fetchUsers khi component được mounted
    onMounted(() => {
      fetchDepartments(currentPage.value);
    });

    // Hàm để chuyển trang
    const changePage = async (newPage) => {
      if (newPage > 0 && newPage <= totalPages.value) {
        await fetchDepartments(newPage);
      }
    };
    // Hàm để xóa người dùng
    const deleteUser = async (id) => {
      try {
        // Hiển thị cửa sổ xác nhận
        const confirmed = confirm(
          `Bạn có muốn xóa người dùng có id là ${id} không?`
        );

        if (confirmed) {
          await axios.delete(`http://127.0.0.1:8000/api/departments/${id}`, {
            headers: {
              Authorization: `Bearer ${userStore.token}`,
            },
          });

          await fetchDepartments(currentPage.value);

          // Hiển thị thông báo xóa thành công
          showDeleteSuccess.value = true;

          setTimeout(() => {
            showDeleteSuccess.value = false;
          }, 2000);
        }
      } catch (error) {
        console.error("Error deleting user:", error);
      }
    };


    return {
      departments,
      deleteUser,
      showDeleteSuccess,
      currentPage,
      totalPages,
      changePage,
      searchQuery,
    };
  },
});
</script>
<template>
  <main class="flex-1 mx-auto lg:ml-64">
    <div
      v-if="showDeleteSuccess"
      class="fixed inset-0 animate-slideDown2 flex items-center justify-center bg-black bg-opacity-0"
    >
      <div class="bg-green-500 text-white py-2 px-4 rounded-md">
        Đã xóa thành công!
      </div>
    </div>
    <div
      class="flex flex-col md:flex-row gap-5 items-center py-7 px-10 border-y border-gray-200"
    >
      <div class="basis-4/5">
        <h1 class="text-2xl font-semibold leading-relaxed text-gray-800">
          User
        </h1>
        <p class="text-sm font-medium text-gray-500">
          Manage departments in the company
        </p>
      </div>
      <input
        type="text"
        v-model="searchQuery"
        placeholder="Search cars..."
        class="py-2 px-4 border-2 border-black rounded-lg"
      />
      <div class="flex gap-5">
        <button
          class="inline-flex py-4 px-4 whitespace-nowrap text-white bg-indigo-600 rounded-xl hover:bg-indigo-700 focus:outline-none"
        >
          <router-link :to="{ name: 'AddDepartment' }" class="text-sm font-semibold"
            >Add Department</router-link
          >
        </button>
        <button
          class="inline-flex py-4 px-4 whitespace-nowrap text-white bg-indigo-600 rounded-xl hover:bg-indigo-700 focus:outline-none"
        >
          <router-link
            :to="{ name: 'ImportUser' }"
            class="text-sm font-semibold tracking-wide"
            >Import excel</router-link
          >
        </button>
      </div>
    </div>
    <div class="overflow-auto rounded-lg shadow hidden md:block">
      <table class="w-full">
        <thead>
          <tr
            class="text-sm font-medium text-gray-700 border-b border-gray-200"
          >
            <th class="pl-10">
              <div class="flex items-center gap-x-4">
                <span>List Departments</span>
              </div>
            </th>
            <th class="py-4 px-4 text-center">Children</th>
            <th class="py-4 px-4 text-center">Created At</th>
          </tr>
        </thead>
        <tbody>
          <tr
            v-for="department in departments"
            :key="department.id"
            class="hover:bg-gray-100 transition-colors group"
          >
            <td class="flex gap-x-4 items-center py-4 pl-10">
              <div>
                <a href="#" class="text-lg font-semibold text-gray-700">{{
                  department.name
                }}</a>
                <div class="font-medium text-gray-400">
                  {{ department.name }}
                </div>
              </div>
            </td>
            <td class="font-medium text-center">
              <ul v-if="department.children && department.children.length > 0">
                <li v-for="child in department.children" :key="child.id">
                  {{child.id}} - {{child.name }}
                </li>
              </ul>
            </td>

            <td class="font-medium text-center">
              <button
                class="py-2 px-4 m-2 bg-orange-500 rounded-lg hover:bg-orange-400"
              >
                <router-link :to="{ name: 'EditDepartment', params: { id: department.id } }"
                  >Edit</router-link
                >
              </button>
              <button
                class="py-2 px-4 m-2 bg-red-500 rounded-lg hover:bg-red-400"
                @click="deleteUser(department.id)"
              >
                Delete
              </button>
            </td>
          </tr>
        </tbody>
      </table>
    </div>
    <div class="grid grid-cols-1 md:grid-cols-2 gap-4 md:hidden p-5">
      <div
        class="bg-white space-y-3 p-4 rounded-lg shadow"
        v-for="department in departments"
        :key="department.id"
      >
        <div class="">
          <div class="text-gray-900">{{}}</div>
          <div class="text-gray-900">email: {{ department.id }}</div>
        </div>
        <div class="text-sm text-gray-700">Chức vụ: {{ department.id }}</div>
        <!-- <button
          class="py-2 px-4 m-2 bg-orange-500 rounded-lg hover:bg-orange-400"
        >
          <router-link :to="{ name: 'EditUser', params: { id: user.id } }"
            >Edit</router-link
          >
        </button>
        <button
          class="py-2 px-4 m-2 bg-red-500 rounded-lg hover:bg-red-400"
          @click="deleteUser(user.id)"
        >
          Delete
        </button> -->
      </div>
    </div>
    <!-- Điều khiển phân trang -->
    <div class="flex justify-center my-4">
      <button
        class="px-4 py-2 bg-green-200 hover:bg-green-500 rounded-lg mx-1 disabled:opacity-50 disabled:bg-gray-200 disabled:text-gray-500 disabled:cursor-not-allowed"
        @click="changePage(currentPage - 1)"
        :disabled="currentPage === 1"
      >
        Previous
      </button>
      <span class="px-4 py-2 text-gray-700">
        Page {{ currentPage }} of {{ totalPages }}
      </span>
      <button
        class="px-4 py-2 bg-green-200 hover:bg-green-500 rounded-lg mx-1 disabled:opacity-50 disabled:bg-gray-200 disabled:hover:bg-gray-200 disabled:text-gray-500 disabled:cursor-not-allowed"
        @click="changePage(currentPage + 1)"
        :disabled="currentPage === totalPages"
      >
        Next
      </button>
    </div>
  </main>
</template>