<script>
import { defineComponent, ref, onMounted, watch } from "vue";
import axios from "axios";
import { useUserStore } from "../../store/auth.js";
export default defineComponent({
  setup() {
    const products = ref([]);
    const showDeleteSuccess = ref(false);
    const currentPage = ref(1); // Trang hiện tại
    const totalPages = ref(0); // Tổng số trang
    const userStore = useUserStore();
    const searchQuery = ref("");
    onMounted(async () => {
      await userStore.fetchUser();
    });
    const fetchProducts = async (page = 1) => {
      try {
        const response = await axios.get(
          `http://127.0.0.1:8000/api/cars?page=${page}&query=${searchQuery.value}`,
          {
            headers: {
              Authorization: `Bearer ${userStore.token}`,
            },
          }
        );
        products.value = response.data.data;
        currentPage.value = response.data.current_page;
        totalPages.value = response.data.last_page;
        if (products.value.length === 0 && currentPage.value > 1) {
          currentPage.value -= 1;
          console.log("hết");
          await fetchProducts(currentPage.value);
        }
      } catch (error) {
        console.error("Error fetching cars:", error);
      }
    };
    watch(searchQuery, () => {
      fetchProducts(currentPage.value);
    });
    onMounted(fetchProducts);
    const changePage = async (newPage) => {
      if (newPage > 0 && newPage <= totalPages.value) {
        await fetchProducts(newPage);
      }
    };
    const deleteProduct = async (id) => {
      try {
        const confirmed = confirm(
          `Bạn có muốn xóa sản phẩm có id là ${id} không ?`
        );

        if (confirmed) {
          await axios.delete(`http://127.0.0.1:8000/api/cars/${id}`, {
            headers: {
              Authorization: `Bearer ${userStore.token}`,
            },
          });
          await fetchProducts(currentPage.value);
          showDeleteSuccess.value = true;
          setTimeout(() => {
            showDeleteSuccess.value = false;
          }, 2000);
        }
      } catch (error) {
        console.error("Error deleting product:", error);
      }
    };

    return {
      products,
      deleteProduct,
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
    <div class="flex flex-col md:flex-row gap-5 items-center py-7 px-10 border-y border-gray-200">
      <div class="basis-4/5">
        <h1 class="text-2xl font-semibold leading-relaxed text-gray-800">
          Car
        </h1>
        <p class="text-sm font-medium text-gray-500">
          Manage cars in the company
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
        class="inline-flex py-4 px-4  whitespace-nowrap text-white bg-indigo-600 rounded-xl hover:bg-indigo-700 focus:outline-none"
      >
        <router-link :to="{ name: 'AddCar' }" class="text-sm font-semibold"
          >Add Car</router-link
        >
      </button>
      <button
        class="inline-flex py-4 px-4 whitespace-nowrap text-white bg-indigo-600 rounded-xl hover:bg-indigo-700 focus:outline-none"
      >
        <router-link
          :to="{ name: 'ImportExcel' }"
          class="text-sm font-semibold tracking-wide"
          >Import excel</router-link
        >
      </button>
      </div>
    </div>

    <div class="overflow-auto rounded-lg shadow hidden md:block">
      <table class="w-full">
        <thead class="bg-gray-50 border-b-2 border-gray-200">
          <tr>
            <th class="py-4 pl-10 text-center">
              <div class="flex items-center gap-x-4">
                <span>List cars</span>
              </div>
            </th>

            <th class="py-4 px-4 text-center">Seating Capacity</th>
            <th class="py-4 px-4 text-center">Default Features</th>
            <th class="py-4 px-4 text-center">Fuel Consumption</th>
            <th class="py-4 pr-10 pl-4 text-center">Actions</th>
          </tr>
        </thead>
        <tbody class="divide-y divide-gray-100">
          <tr
            v-for="product in products"
            :key="product.id"
            class="hover:bg-gray-100 transition-colors group"
          >
            <td class="flex gap-x-4 items-center py-4 pl-10">
              <img
                :src="product.anh_xe"
                alt=""
                class="w-40 aspect-[3/2] rounded-lg object-cover object-top border border-gray-200"
              />
              <div class="text-lg font-semibold text-gray-700">
                <a href="#">{{ product.ten_xe }}</a>
                <div>Car's user: {{ product.user_id }}</div>
              </div>
            </td>
            <td class="font-medium text-center">{{ product.so_cho }}</td>
            <td class="font-medium text-center">
              {{ product.dac_diem_mac_dinh }}
            </td>
            <td class="font-medium text-center">
              {{ product.so_dau_xang_tieu_thu }}km/l
            </td>
            <td class="font-medium text-center">
              <button
                class="py-2 px-4 m-2 bg-orange-500 rounded-lg hover:bg-orange-400"
              >
                <router-link :to="{ name: 'Edit', params: { id: product.id } }"
                  >Edit</router-link
                >
              </button>
              <button
                class="py-2 px-4 m-2 bg-red-500 rounded-lg hover:bg-red-400"
                @click="deleteProduct(product.id)"
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
        v-for="product in products"
        :key="product.id"
      >
        <div class="flex items-center space-x-2 text-sm">
          <div class="text-gray-900">{{ product.ten_xe }}</div>
          <div class="text-gray-900">User name: {{ product.user_id }}</div>
        </div>
        <div class="text-sm text-gray-700">Số chỗ: {{ product.so_cho }}</div>
        <button
          class="py-2 px-4 m-2 bg-orange-500 rounded-lg hover:bg-orange-400"
        >
          <router-link :to="{ name: 'Edit', params: { id: product.id } }"
            >Edit</router-link
          >
        </button>
        <button
          class="py-2 px-4 m-2 bg-red-500 rounded-lg hover:bg-red-400"
          @click="deleteProduct(product.id)"
        >
          Delete
        </button>
      </div>
    </div>
    <!-- Điều khiển phân trang -->
    <div class="flex justify-center my-4">
      <button
        class="px-4 py-2 bg-green-200 hover:bg-green-500 rounded-lg mx-1 disabled:opacity-50 disabled:bg-gray-200  disabled:text-gray-500 disabled:cursor-not-allowed"
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
