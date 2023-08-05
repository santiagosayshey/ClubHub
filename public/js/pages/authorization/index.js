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

/***/ "./src/js/pages/authorization/index.js":
/*!*********************************************!*\
  !*** ./src/js/pages/authorization/index.js ***!
  \*********************************************/
/***/ (() => {

eval("class Login {\n  constructor() {\n    this.emailInput = document.getElementById('email');\n    this.passwordInput = document.getElementById('password');\n    this.loginButton = document.getElementById('login');\n    this.loginButton.addEventListener('click', event => this.submitForm(event));\n  }\n  submitForm(event) {\n    event.preventDefault();\n    const email = this.emailInput.value;\n    const password = this.passwordInput.value;\n    const xhttp = new XMLHttpRequest();\n    xhttp.open(\"POST\", '/login/authenticate', true);\n    xhttp.setRequestHeader('Content-Type', 'application/json');\n    xhttp.onreadystatechange = function () {\n      if (xhttp.readyState === 4 && xhttp.status === 200) {\n        const response = JSON.parse(xhttp.responseText);\n        if (response.redirect) {\n          window.location.href = response.redirect;\n        }\n      } else if (xhttp.readyState === 4 && xhttp.status === 401) {\n        const response = JSON.parse(xhttp.responseText);\n        const errorMessage = encodeURIComponent(response.error);\n        window.location.href = \"/login?errorMessage=\" + errorMessage;\n      } else if (xhttp.readyState === 4 && xhttp.status === 403) {\n        const response = JSON.parse(xhttp.responseText);\n        const errorMessage = encodeURIComponent(response.error);\n        window.location.href = \"/login?errorMessage=\" + errorMessage;\n      }\n    };\n    const data = JSON.stringify({\n      email,\n      password\n    });\n    xhttp.send(data);\n  }\n}\ndocument.addEventListener('DOMContentLoaded', event => {\n  const login = new Login();\n});\n\n//# sourceURL=webpack://23s1_wdc_ug054_radio-head-/./src/js/pages/authorization/index.js?");

/***/ })

/******/ 	});
/************************************************************************/
/******/ 	
/******/ 	// startup
/******/ 	// Load entry module and return exports
/******/ 	// This entry module can't be inlined because the eval devtool is used.
/******/ 	var __webpack_exports__ = {};
/******/ 	__webpack_modules__["./src/js/pages/authorization/index.js"]();
/******/ 	
/******/ })()
;