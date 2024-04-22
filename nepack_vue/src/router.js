import { createRouter, createWebHistory } from "vue-router";
import { useUserStore } from "./store/auth.js";
import Car from "./components/Car/Car.vue";
import AddCar from "./components/Car/AddCar.vue";
import EditCar from "./components/Car/edit.vue";
import ImportCar from "./components/Car/ImportExcel.vue";
import User from "./components/User/User.vue";
import AddUser from "./components/User/addUser.vue";
import EditUser from "./components/User/EditUser.vue";
import ImportUser from "./components/User/importUser.vue";
import Department from "./components/Department/Department.vue";
import AddDepartment from "./components/Department/AddDepartment.vue";
import EditDepartment from "./components/Department/EditDepartment.vue";
import login from "./Auth/login.vue";
import Unauthorized from "./components/Unauthorized.vue";
import ForgotPassword from "./Auth/ForgotPassword.vue";
import Home from "./components/Home.vue";
const Roles = {
  ADMIN: 'admin',
  QUAN_TRI_CONG_TAC: 'quản trị công tác',
  QUAN_TRI_VAT_TU: 'quản trị vật tư',
  USER: 'user',
}

const canAccess = (userRole, roles) => {
  return roles.includes(userRole);
}

const routes = [
  {
    path: "/",
    redirect: "/cars"
  },
  {
    path: "/unauthorized",
    name: "Unauthorized",
    component: Unauthorized
  },
  {
    path: "/cars",
    name: "Car",
    component: Car,
    meta: { requiresAuth: true, roles: [Roles.ADMIN, Roles.QUAN_TRI_VAT_TU] }
  },
  {
    path: "/cars/add",
    name: "AddCar",
    component: AddCar,
    meta: { requiresAuth: true, roles: [Roles.ADMIN, Roles.QUAN_TRI_VAT_TU] }
  },
  {
    path: "/cars/edit/:id",
    name: "Edit",
    component: EditCar,
    meta: { requiresAuth: true, roles: [Roles.ADMIN, Roles.QUAN_TRI_VAT_TU] }
  },
  {
    path: "/cars/importexcel",
    name: "ImportExcel",
    component: ImportCar,
    meta: { requiresAuth: true, roles: [Roles.ADMIN, Roles.QUAN_TRI_VAT_TU] }
  },
  {
    path: "/users",
    name: "User",
    component: User,
    meta: { requiresAuth: true, roles: [Roles.ADMIN] }
  },
  {
    path: "/users/add",
    name: "AddUser",
    component: AddUser,
    meta: { requiresAuth: true, roles: [Roles.ADMIN] }
  },
  {
    path: "/users/edit/:id",
    name: "EditUser",
    component: EditUser,
    meta: { requiresAuth: true, roles: [Roles.ADMIN] }
  },
  {
    path: "/users/importuser",
    name: "ImportUser",
    component: ImportUser,
    meta: { requiresAuth: true, roles: [Roles.ADMIN] }
  },
  { path: "/login", name: "Login", component: login },
  {
    path: "/forgot-password",
    name: "ForgotPassword",
    component: ForgotPassword
  },
  {
    path: "/home",
    name: "Home",
    component: Home,
    meta: { requiresAuth: true, roles: [Roles.ADMIN, Roles.USER] }
  },
  {
    path: '/:catchAll(.*)',
    name: 'Unauthorized',
    component: Unauthorized
  },
  {
    path: "/department",
    name: "Department",
    component: Department,
    meta: { requiresAuth: true, roles: [Roles.ADMIN, Roles.QUAN_TRI_CONG_TAC] }
  },
  {
    path: "/department/add",
    name: "AddDepartment",
    component: AddDepartment,
    meta: { requiresAuth: true, roles: [Roles.ADMIN, Roles.QUAN_TRI_CONG_TAC] }
  },
  {
    path: "/department/edit/:id",
    name: "EditDepartment",
    component: EditDepartment,
    meta: { requiresAuth: true, roles: [Roles.ADMIN, Roles.QUAN_TRI_CONG_TAC] }
  }

];

const router = createRouter({
  history: createWebHistory(),
  routes
});

router.beforeEach(async (to, from, next) => {
    const userStore = useUserStore();

    // Kiểm tra xem người dùng đã đăng nhập chưa
    if (!userStore.getUser && userStore.getToken) {
        await userStore.fetchUser();
    }

    // Nếu yêu cầu route yêu cầu xác thực
    if (to.meta.requiresAuth) {
        // Nếu không có token (chưa đăng nhập), chuyển hướng đến trang đăng nhập
        if (!userStore.getToken) {
            next({ name: 'Login', query: { redirect: to.fullPath } });
        } else {
            // Kiểm tra quyền truy cập dựa trên vai trò của người dùng
            const userRole = userStore.user.role;

            if (!canAccess(userRole, to.meta.roles)) {
                // Nếu người dùng không có quyền truy cập vào route, chuyển hướng đến trang không được phép truy cập
                next({ name: 'Unauthorized' });
            } else {
                // Người dùng có quyền truy cập vào route, kiểm tra vai trò của họ
                if (to.name === 'Login' && (userRole === Roles.ADMIN || userRole === Roles.QUAN_TRI_CONG_TACT || userRole === Roles.QUAN_TRI_VAT_TU)) {
                    // Nếu người dùng là admin và yêu cầu đăng nhập, chuyển hướng đến trang Car
                    next({ name: 'Car' });
                } else if (to.name === 'Login' && userRole === Roles.USER) {
                    // Nếu người dùng là user và yêu cầu đăng nhập, chuyển hướng đến trang home (giả định)
                    next({ name: 'Home' });
                } else {
                    // Người dùng có thể vào route
                    next();
                }
            }
        }
    } else {
        // Route không yêu cầu xác thực, tiếp tục
        next();
    }
});


export default router;
