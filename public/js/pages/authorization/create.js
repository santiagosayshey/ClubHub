/*
 * ATTENTION: The "eval" devtool has been used (maybe by default in mode: "development").
 * This devtool is neither made for production nor for readable output files.
 * It uses "eval()" calls to create a separate source file in the browser devtools.
 * If you are trying to read the output file, select a different devtool (https://webpack.js.org/configuration/devtool/)
 * or disable the default devtool with "devtool: false".
 * If you are looking for production-ready output files, see mode: "production" (https://webpack.js.org/configuration/mode/).
 */
/******/ (() => { // webpackBootstrap
/******/ 	var __webpack_modules__ = ({

/***/ "./src/js/pages/authorization/create.js":
/*!**********************************************!*\
  !*** ./src/js/pages/authorization/create.js ***!
  \**********************************************/
/***/ (() => {

eval("class Login {\n  constructor() {\n    this.firstnameInput = document.getElementById('firstname');\n    this.lastnameInput = document.getElementById('lastname');\n    this.emailInput = document.getElementById('email');\n    this.passwordInput = document.getElementById('password');\n    this.loginButton = document.getElementById('login');\n    this.loginButton.addEventListener('click', event => this.submitForm(event));\n  }\n  submitForm(event) {\n    event.preventDefault();\n    const firstname = this.firstnameInput.value;\n    const lastname = this.lastnameInput.value;\n    const email = this.emailInput.value;\n    const password = this.passwordInput.value;\n    const emailRegex = /^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$/;\n    if (!emailRegex.test(email)) {\n      alert('Please enter a valid email address.');\n      return;\n    }\n    if (firstname.trim() === '') {\n      alert('Please enter a first name.');\n      return;\n    }\n    if (lastname.trim() === '') {\n      alert('Please enter a last name.');\n      return;\n    }\n    if (password !== '' && password.length < 8) {\n      alert('Password should be at least 8 characters long.');\n      return;\n    }\n    const xhttp = new XMLHttpRequest();\n    xhttp.open(\"POST\", '/login/create', true);\n    xhttp.setRequestHeader('Content-Type', 'application/json');\n    xhttp.onreadystatechange = function () {\n      if (xhttp.readyState === 4) {\n        if (xhttp.status === 200) {\n          const response = JSON.parse(xhttp.responseText);\n          window.location.href = \"/login\";\n        } else if (xhttp.status === 400) {\n          const response = JSON.parse(xhttp.responseText);\n          const errorMessage = encodeURIComponent(response.error);\n          window.location.href = \"/login/create?errorMessage=\" + errorMessage;\n        } else {\n          window.location.href = \"/login/create?errorMessage=\\\"An error occurred please try again later\\\"\";\n        }\n      }\n    };\n    const data = JSON.stringify({\n      firstname,\n      lastname,\n      email,\n      password\n    });\n    xhttp.send(data);\n  }\n}\ndocument.addEventListener('DOMContentLoaded', event => {\n  const login = new Login();\n});\n\n//# sourceURL=webpack://23s1_wdc_ug054_radio-head-/./src/js/pages/authorization/create.js?");

/***/ })

/******/ 	});
/************************************************************************/
/******/ 	
/******/ 	// startup
/******/ 	// Load entry module and return exports
/******/ 	// This entry module can't be inlined because the eval devtool is used.
/******/ 	var __webpack_exports__ = {};
/******/ 	__webpack_modules__["./src/js/pages/authorization/create.js"]();
/******/ 	
/******/ })()
;