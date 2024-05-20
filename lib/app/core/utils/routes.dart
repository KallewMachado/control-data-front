const routesPath = (
  auth: (
    path: '/',
    register: '/register',
    home: '/home/',
  ),
  home: (
    path: '/',
    registerUser: '/home/register/user',
    demands: '/demands',
    initial: '/home/initial/',
    users: '/users',
    config: '/config',
  ),
  demands: (
    path: '/',
    register: '/register',
  ),
  user: (
    path: '/',
    demands: '/home/demands/',
  ),
  changeDemand: '/changeDemands',
  changeUser: '/changeUser',
  changePassword: '/changePassword',
  resetPassword: '/resetPassword',
  sendForgot: '/sendForgot',
  verifyOTP: '/verifyOTP',
);
