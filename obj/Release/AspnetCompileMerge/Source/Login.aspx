<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="eCerpac_NIS.Login" %>

<!DOCTYPE html>

<html lang="en">
<merlin-component id="merlin-text-summarizer" class="merlin text-summarizer"></merlin-component>
<merlin-component id="merlin-context-btn" class="merlin context-btn"></merlin-component>
<merlin-component id="merlin-chat" class="merlin chat"></merlin-component>
<head>
    <meta charset="utf-8">
    <link rel="icon" href="/favicon.ico">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <meta name="theme-color" content="#000000">
    <meta name="description" content="Web site created using create-react-app">
    <link rel="apple-touch-icon" href="eImage_files/logo192.png">
    <link rel="manifest" href="/manifest.json">
    <link href="https://fonts.cdnfonts.com/css/sharp-sans" rel="stylesheet">
    <title>eCERPAC </title>

    <script defer="defer" src="eImage_files/main.cab8eaeb.js.download"></script>
    <link href="eImage_files/main.c327fa76.css" rel="stylesheet">


    <style type="text/css">
        * {
            font-size: 12px;
        }

    
        :where(html[dir="ltr"]), :where([data-sonner-toaster][dir="ltr"]) {
            --toast-icon-margin-start: -3px;
            --toast-icon-margin-end: 4px;
            --toast-svg-margin-start: -1px;
            --toast-svg-margin-end: 0px;
            --toast-button-margin-start: auto;
            --toast-button-margin-end: 0;
            --toast-close-button-start: 0;
            --toast-close-button-end: unset;
            --toast-close-button-transform: translate(-35%, -35%)
        }

        :where(html[dir="rtl"]), :where([data-sonner-toaster][dir="rtl"]) {
            --toast-icon-margin-start: 4px;
            --toast-icon-margin-end: -3px;
            --toast-svg-margin-start: 0px;
            --toast-svg-margin-end: -1px;
            --toast-button-margin-start: 0;
            --toast-button-margin-end: auto;
            --toast-close-button-start: unset;
            --toast-close-button-end: 0;
            --toast-close-button-transform: translate(35%, -35%)
        }

        :where([data-sonner-toaster]) {
            position: fixed;
            width: var(--width);
            font-family: ui-sans-serif,system-ui,-apple-system,BlinkMacSystemFont,Segoe UI,Roboto,Helvetica Neue,Arial,Noto Sans,sans-serif,Apple Color Emoji,Segoe UI Emoji,Segoe UI Symbol,Noto Color Emoji;
            --gray1: hsl(0, 0%, 99%);
            --gray2: hsl(0, 0%, 97.3%);
            --gray3: hsl(0, 0%, 95.1%);
            --gray4: hsl(0, 0%, 93%);
            --gray5: hsl(0, 0%, 90.9%);
            --gray6: hsl(0, 0%, 88.7%);
            --gray7: hsl(0, 0%, 85.8%);
            --gray8: hsl(0, 0%, 78%);
            --gray9: hsl(0, 0%, 56.1%);
            --gray10: hsl(0, 0%, 52.3%);
            --gray11: hsl(0, 0%, 43.5%);
            --gray12: hsl(0, 0%, 9%);
            --border-radius: 8px;
            box-sizing: border-box;
            padding: 0;
            margin: 0;
            list-style: none;
            outline: none;
            z-index: 999999999
        }

        :where([data-sonner-toaster][data-x-position="right"]) {
            right: max(var(--offset),env(safe-area-inset-right))
        }

        :where([data-sonner-toaster][data-x-position="left"]) {
            left: max(var(--offset),env(safe-area-inset-left))
        }

        :where([data-sonner-toaster][data-x-position="center"]) {
            left: 50%;
            transform: translate(-50%)
        }

        :where([data-sonner-toaster][data-y-position="top"]) {
            top: max(var(--offset),env(safe-area-inset-top))
        }

        :where([data-sonner-toaster][data-y-position="bottom"]) {
            bottom: max(var(--offset),env(safe-area-inset-bottom))
        }

        :where([data-sonner-toast]) {
            --y: translateY(100%);
            --lift-amount: calc(var(--lift) * var(--gap));
            z-index: var(--z-index);
            position: absolute;
            opacity: 0;
            transform: var(--y);
            filter: blur(0);
            touch-action: none;
            transition: transform .4s,opacity .4s,height .4s,box-shadow .2s;
            box-sizing: border-box;
            outline: none;
            overflow-wrap: anywhere
        }

        :where([data-sonner-toast][data-styled="true"]) {
            padding: 16px;
            background: var(--normal-bg);
            border: 1px solid var(--normal-border);
            color: var(--normal-text);
            border-radius: var(--border-radius);
            box-shadow: 0 4px 12px #0000001a;
            width: var(--width);
            font-size: 13px;
            display: flex;
            align-items: center;
            gap: 6px
        }

        :where([data-sonner-toast]:focus-visible) {
            box-shadow: 0 4px 12px #0000001a,0 0 0 2px #0003
        }

        :where([data-sonner-toast][data-y-position="top"]) {
            top: 0;
            --y: translateY(-100%);
            --lift: 1;
            --lift-amount: calc(1 * var(--gap))
        }

        :where([data-sonner-toast][data-y-position="bottom"]) {
            bottom: 0;
            --y: translateY(100%);
            --lift: -1;
            --lift-amount: calc(var(--lift) * var(--gap))
        }

        :where([data-sonner-toast]) :where([data-description]) {
            font-weight: 400;
            line-height: 1.4;
            color: inherit
        }

        :where([data-sonner-toast]) :where([data-title]) {
            font-weight: 500;
            line-height: 1.5;
            color: inherit
        }

        :where([data-sonner-toast]) :where([data-icon]) {
            display: flex;
            height: 16px;
            width: 16px;
            position: relative;
            justify-content: flex-start;
            align-items: center;
            flex-shrink: 0;
            margin-left: var(--toast-icon-margin-start);
            margin-right: var(--toast-icon-margin-end)
        }

        :where([data-sonner-toast][data-promise="true"]) :where([data-icon]) > svg {
            opacity: 0;
            transform: scale(.8);
            transform-origin: center;
            animation: sonner-fade-in .3s ease forwards
        }

        :where([data-sonner-toast]) :where([data-icon]) > * {
            flex-shrink: 0
        }

        :where([data-sonner-toast]) :where([data-icon]) svg {
            margin-left: var(--toast-svg-margin-start);
            margin-right: var(--toast-svg-margin-end)
        }

        :where([data-sonner-toast]) :where([data-content]) {
            display: flex;
            flex-direction: column;
            gap: 2px
        }

        [data-sonner-toast][data-styled=true] [data-button] {
            border-radius: 4px;
            padding-left: 8px;
            padding-right: 8px;
            height: 24px;
            font-size: 12px;
            color: var(--normal-bg);
            background: var(--normal-text);
            margin-left: var(--toast-button-margin-start);
            margin-right: var(--toast-button-margin-end);
            border: none;
            cursor: pointer;
            outline: none;
            display: flex;
            align-items: center;
            flex-shrink: 0;
            transition: opacity .4s,box-shadow .2s
        }

        :where([data-sonner-toast]) :where([data-button]):focus-visible {
            box-shadow: 0 0 0 2px #0006
        }

        :where([data-sonner-toast]) :where([data-button]):first-of-type {
            margin-left: var(--toast-button-margin-start);
            margin-right: var(--toast-button-margin-end)
        }

        :where([data-sonner-toast]) :where([data-cancel]) {
            color: var(--normal-text);
            background: rgba(0,0,0,.08)
        }

        :where([data-sonner-toast][data-theme="dark"]) :where([data-cancel]) {
            background: rgba(255,255,255,.3)
        }

        :where([data-sonner-toast]) :where([data-close-button]) {
            position: absolute;
            left: var(--toast-close-button-start);
            right: var(--toast-close-button-end);
            top: 0;
            height: 20px;
            width: 20px;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 0;
            background: var(--gray1);
            color: var(--gray12);
            border: 1px solid var(--gray4);
            transform: var(--toast-close-button-transform);
            border-radius: 50%;
            cursor: pointer;
            z-index: 1;
            transition: opacity .1s,background .2s,border-color .2s
        }

            :where([data-sonner-toast]) :where([data-close-button]):focus-visible {
                box-shadow: 0 4px 12px #0000001a,0 0 0 2px #0003
            }

        :where([data-sonner-toast]) :where([data-disabled="true"]) {
            cursor: not-allowed
        }

        :where([data-sonner-toast]):hover :where([data-close-button]):hover {
            background: var(--gray2);
            border-color: var(--gray5)
        }

        :where([data-sonner-toast][data-swiping="true"]):before {
            content: "";
            position: absolute;
            left: 0;
            right: 0;
            height: 100%;
            z-index: -1
        }

        :where([data-sonner-toast][data-y-position="top"][data-swiping="true"]):before {
            bottom: 50%;
            transform: scaleY(3) translateY(50%)
        }

        :where([data-sonner-toast][data-y-position="bottom"][data-swiping="true"]):before {
            top: 50%;
            transform: scaleY(3) translateY(-50%)
        }

        :where([data-sonner-toast][data-swiping="false"][data-removed="true"]):before {
            content: "";
            position: absolute;
            inset: 0;
            transform: scaleY(2)
        }

        :where([data-sonner-toast]):after {
            content: "";
            position: absolute;
            left: 0;
            height: calc(var(--gap) + 1px);
            bottom: 100%;
            width: 100%
        }

        :where([data-sonner-toast][data-mounted="true"]) {
            --y: translateY(0);
            opacity: 1
        }

        :where([data-sonner-toast][data-expanded="false"][data-front="false"]) {
            --scale: var(--toasts-before) * .05 + 1;
            --y: translateY(calc(var(--lift-amount) * var(--toasts-before))) scale(calc(-1 * var(--scale)));
            height: var(--front-toast-height)
        }

        :where([data-sonner-toast]) > * {
            transition: opacity .4s
        }

        :where([data-sonner-toast][data-expanded="false"][data-front="false"][data-styled="true"]) > * {
            opacity: 0
        }

        :where([data-sonner-toast][data-visible="false"]) {
            opacity: 0;
            pointer-events: none
        }

        :where([data-sonner-toast][data-mounted="true"][data-expanded="true"]) {
            --y: translateY(calc(var(--lift) * var(--offset)));
            height: var(--initial-height)
        }

        :where([data-sonner-toast][data-removed="true"][data-front="true"][data-swipe-out="false"]) {
            --y: translateY(calc(var(--lift) * -100%));
            opacity: 0
        }

        :where([data-sonner-toast][data-removed="true"][data-front="false"][data-swipe-out="false"][data-expanded="true"]) {
            --y: translateY(calc(var(--lift) * var(--offset) + var(--lift) * -100%));
            opacity: 0
        }

        :where([data-sonner-toast][data-removed="true"][data-front="false"][data-swipe-out="false"][data-expanded="false"]) {
            --y: translateY(40%);
            opacity: 0;
            transition: transform .5s,opacity .2s
        }

        :where([data-sonner-toast][data-removed="true"][data-front="false"]):before {
            height: calc(var(--initial-height) + 20%)
        }

        [data-sonner-toast][data-swiping=true] {
            transform: var(--y) translateY(var(--swipe-amount, 0px));
            transition: none
        }

        [data-sonner-toast][data-swipe-out=true][data-y-position=bottom], [data-sonner-toast][data-swipe-out=true][data-y-position=top] {
            animation: swipe-out .2s ease-out forwards
        }

        @keyframes swipe-out {
            0% {
                transform: translateY(calc(var(--lift) * var(--offset) + var(--swipe-amount)));
                opacity: 1
            }

            to {
                transform: translateY(calc(var(--lift) * var(--offset) + var(--swipe-amount) + var(--lift) * -100%));
                opacity: 0
            }
        }

        @media (max-width: 600px) {
            [data-sonner-toaster] {
                position: fixed;
                --mobile-offset: 16px;
                right: var(--mobile-offset);
                left: var(--mobile-offset);
                width: 100%
            }

                [data-sonner-toaster] [data-sonner-toast] {
                    left: 0;
                    right: 0;
                    width: calc(100% - var(--mobile-offset) * 2)
                }

                [data-sonner-toaster][data-x-position=left] {
                    left: var(--mobile-offset)
                }

                [data-sonner-toaster][data-y-position=bottom] {
                    bottom: 20px
                }

                [data-sonner-toaster][data-y-position=top] {
                    top: 20px
                }

                [data-sonner-toaster][data-x-position=center] {
                    left: var(--mobile-offset);
                    right: var(--mobile-offset);
                    transform: none
                }
        }

        [data-sonner-toaster][data-theme=light] {
            --normal-bg: #fff;
            --normal-border: var(--gray4);
            --normal-text: var(--gray12);
            --success-bg: hsl(143, 85%, 96%);
            --success-border: hsl(145, 92%, 91%);
            --success-text: hsl(140, 100%, 27%);
            --info-bg: hsl(208, 100%, 97%);
            --info-border: hsl(221, 91%, 91%);
            --info-text: hsl(210, 92%, 45%);
            --warning-bg: hsl(49, 100%, 97%);
            --warning-border: hsl(49, 91%, 91%);
            --warning-text: hsl(31, 92%, 45%);
            --error-bg: hsl(359, 100%, 97%);
            --error-border: hsl(359, 100%, 94%);
            --error-text: hsl(360, 100%, 45%)
        }

            [data-sonner-toaster][data-theme=light] [data-sonner-toast][data-invert=true] {
                --normal-bg: #000;
                --normal-border: hsl(0, 0%, 20%);
                --normal-text: var(--gray1)
            }

        [data-sonner-toaster][data-theme=dark] [data-sonner-toast][data-invert=true] {
            --normal-bg: #fff;
            --normal-border: var(--gray3);
            --normal-text: var(--gray12)
        }

        [data-sonner-toaster][data-theme=dark] {
            --normal-bg: #000;
            --normal-border: hsl(0, 0%, 20%);
            --normal-text: var(--gray1);
            --success-bg: hsl(150, 100%, 6%);
            --success-border: hsl(147, 100%, 12%);
            --success-text: hsl(150, 86%, 65%);
            --info-bg: hsl(215, 100%, 6%);
            --info-border: hsl(223, 100%, 12%);
            --info-text: hsl(216, 87%, 65%);
            --warning-bg: hsl(64, 100%, 6%);
            --warning-border: hsl(60, 100%, 12%);
            --warning-text: hsl(46, 87%, 65%);
            --error-bg: hsl(358, 76%, 10%);
            --error-border: hsl(357, 89%, 16%);
            --error-text: hsl(358, 100%, 81%)
        }

        [data-rich-colors=true][data-sonner-toast][data-type=success], [data-rich-colors=true][data-sonner-toast][data-type=success] [data-close-button] {
            background: var(--success-bg);
            border-color: var(--success-border);
            color: var(--success-text)
        }

        [data-rich-colors=true][data-sonner-toast][data-type=info], [data-rich-colors=true][data-sonner-toast][data-type=info] [data-close-button] {
            background: var(--info-bg);
            border-color: var(--info-border);
            color: var(--info-text)
        }

        [data-rich-colors=true][data-sonner-toast][data-type=warning], [data-rich-colors=true][data-sonner-toast][data-type=warning] [data-close-button] {
            background: var(--warning-bg);
            border-color: var(--warning-border);
            color: var(--warning-text)
        }

        [data-rich-colors=true][data-sonner-toast][data-type=error], [data-rich-colors=true][data-sonner-toast][data-type=error] [data-close-button] {
            background: var(--error-bg);
            border-color: var(--error-border);
            color: var(--error-text)
        }

        .sonner-loading-wrapper {
            --size: 16px;
            height: var(--size);
            width: var(--size);
            position: absolute;
            inset: 0;
            z-index: 10
        }

            .sonner-loading-wrapper[data-visible=false] {
                transform-origin: center;
                animation: sonner-fade-out .2s ease forwards
            }

        .sonner-spinner {
            position: relative;
            top: 50%;
            left: 50%;
            height: var(--size);
            width: var(--size)
        }

        .sonner-loading-bar {
            animation: sonner-spin 1.2s linear infinite;
            background: var(--gray11);
            border-radius: 6px;
            height: 8%;
            left: -10%;
            position: absolute;
            top: -3.9%;
            width: 24%
        }

            .sonner-loading-bar:nth-child(1) {
                animation-delay: -1.2s;
                transform: rotate(.0001deg) translate(146%)
            }

            .sonner-loading-bar:nth-child(2) {
                animation-delay: -1.1s;
                transform: rotate(30deg) translate(146%)
            }

            .sonner-loading-bar:nth-child(3) {
                animation-delay: -1s;
                transform: rotate(60deg) translate(146%)
            }

            .sonner-loading-bar:nth-child(4) {
                animation-delay: -.9s;
                transform: rotate(90deg) translate(146%)
            }

            .sonner-loading-bar:nth-child(5) {
                animation-delay: -.8s;
                transform: rotate(120deg) translate(146%)
            }

            .sonner-loading-bar:nth-child(6) {
                animation-delay: -.7s;
                transform: rotate(150deg) translate(146%)
            }

            .sonner-loading-bar:nth-child(7) {
                animation-delay: -.6s;
                transform: rotate(180deg) translate(146%)
            }

            .sonner-loading-bar:nth-child(8) {
                animation-delay: -.5s;
                transform: rotate(210deg) translate(146%)
            }

            .sonner-loading-bar:nth-child(9) {
                animation-delay: -.4s;
                transform: rotate(240deg) translate(146%)
            }

            .sonner-loading-bar:nth-child(10) {
                animation-delay: -.3s;
                transform: rotate(270deg) translate(146%)
            }

            .sonner-loading-bar:nth-child(11) {
                animation-delay: -.2s;
                transform: rotate(300deg) translate(146%)
            }

            .sonner-loading-bar:nth-child(12) {
                animation-delay: -.1s;
                transform: rotate(330deg) translate(146%)
            }

        @keyframes sonner-fade-in {
            0% {
                opacity: 0;
                transform: scale(.8)
            }

            to {
                opacity: 1;
                transform: scale(1)
            }
        }

        @keyframes sonner-fade-out {
            0% {
                opacity: 1;
                transform: scale(1)
            }

            to {
                opacity: 0;
                transform: scale(.8)
            }
        }

        @keyframes sonner-spin {
            0% {
                opacity: 1
            }

            to {
                opacity: .15
            }
        }

        @media (prefers-reduced-motion) {
            [data-sonner-toast], [data-sonner-toast] > *, .sonner-loading-bar {
                transition: none !important;
                animation: none !important
            }
        }

        .sonner-loader {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%,-50%);
            transform-origin: center;
            transition: opacity .2s,transform .2s
        }

            .sonner-loader[data-visible=false] {
                opacity: 0;
                transform: scale(.8) translate(-50%,-50%)
            }
    </style>

    <style data-emotion="css" data-s=""></style>

    <script type="text/javascript">
        var togglePassword = document.querySelector('#togglePassword');
        var password = document.querySelector('#txtPassword');
        if (password != null) {
            togglePassword.addEventListener('click', function (e) {

                const type = password.getAttribute('type') === 'password' ? 'text' : 'password';
                password.setAttribute('type', type);
                this.classList.toggle('fa-eye-slash');
            });
        }
       <%-- document.addEventListener("DOMContentLoaded", function () {
            var togglePassword = document.getElementById('togglePassword');
    var password = document.getElementById('<%= txtPassword.ClientID %>');

           if (togglePassword && password) {
               togglePassword.addEventListener("click", function () {
                   const isPassword = password.type === "password";
                   password.type = isPassword ? "text" : "password";

                   // Toggle eye icon
                   this.classList.toggle("fa-eye");
                   this.classList.toggle("fa-eye-slash");
               });
           } else {
               console.error("Password field or toggle button not found.");
           }
       });--%>
</script>

    
</head>
<body>
    <noscript>You need to enable JavaScript to run this app.</noscript>
    <div id="root">
        <div>
            <div class="navbar-container-dasboard">
                <div class="navbar-container-content-dashboard">
                    <div class="immigration-logo">
                        <img src="..\eImage_files\logo.png" alt="Logo">
                    </div>
                    <div class="navbar-list-btn-dashboard">
                        <ul type="none" class="navbar-list-items-dashboard fs-20-vw fw-600">

                            <li>Home<svg stroke="currentColor" fill="currentColor" stroke-width="0" viewBox="0 0 512 512" height="1em" width="1em" xmlns="http://www.w3.org/2000/svg"><path d="M128 192l128 128 128-128z"></path></svg></li>

                            <li><a href="AboutUs.aspx" style="text-decoration: none; color: inherit;">About Us</a><svg stroke="currentColor" fill="currentColor" stroke-width="0" viewBox="0 0 512 512" height="1em" width="1em" xmlns="http://www.w3.org/2000/svg"><path d="M128 192l128 128 128-128z"></path></svg></li>

                            <li><a href="Guidelines.aspx" style="text-decoration: none; color: inherit;">eCerpac Guidelines</a><svg stroke="currentColor" fill="currentColor" stroke-width="0" viewBox="0 0 512 512" height="1em" width="1em" xmlns="http://www.w3.org/2000/svg"><path d="M128 192l128 128 128-128z"></path></svg></li>

                            <li><a href="ZonalOffices.aspx" style="text-decoration: none; color: inherit;">Zonal Offices</a><svg stroke="currentColor" fill="currentColor" stroke-width="0" viewBox="0 0 512 512" height="1em" width="1em" xmlns="http://www.w3.org/2000/svg"><path d="M128 192l128 128 128-128z"></path></svg></li>

                            <li><a href="CerpacFee.aspx" style="text-decoration: none; color: inherit;">eCerpac Fees</a><svg stroke="currentColor" fill="currentColor" stroke-width="0" viewBox="0 0 512 512" height="1em" width="1em" xmlns="http://www.w3.org/2000/svg"><path d="M128 192l128 128 128-128z"></path></svg></li>

                            <li>Terms & Conditions<svg stroke="currentColor" fill="currentColor" stroke-width="0" viewBox="0 0 512 512" height="1em" width="1em" xmlns="http://www.w3.org/2000/svg"><path d="M128 192l128 128 128-128z"></path></svg></li>

                            <li>Licence<svg stroke="currentColor" fill="currentColor" stroke-width="0" viewBox="0 0 512 512" height="1em" width="1em" xmlns="http://www.w3.org/2000/svg"><path d="M128 192l128 128 128-128z"></path></svg></li>

                            <li>Contact Us<svg stroke="currentColor" fill="currentColor" stroke-width="0" viewBox="0 0 512 512" height="1em" width="1em" xmlns="http://www.w3.org/2000/svg"><path d="M128 192l128 128 128-128z"></path></svg></li>


                        </ul>
                        <button class="navbar-btn-dashboard">
                            <img src="../Images/Dashboard/report.png.png" alt="logo_btn" style="width: 7.708vw; height: 1.823vw; display: none;"></button>
                    </div>
                </div>
            </div>
            <div class="bottom-navbar-container">eCERPAC Signin</div>
            <div class="footer-navbar-content">
                <div class="footer-navbar-text fs-50-3-vw fw-700">
                    eCERPAC<br>
                    Management System
                </div>
                <div>
                    <img src="eImage_files\new_flag.png" alt="flag_image">
                </div>
            </div>
            <div class="main-container">
                <div class="top-section">
                    <div class="left-panel">
                        <div class="left-content">
                            <div class="icon">
                                <img src="eImage_files/new-login-box-img.png" alt="eCERPAC Icon">
                            </div>
                            <h1 class="fs-50-417-vw fw-700">eCERPAC</h1>
                            <div class="left-panel-data fs-24-vw fw-500">The system for foreigners in Nigeria, consolidating residence and work permits.</div>
                        </div>
                    </div>
                    <hr class="vertical_line">
                    <div class="right-panel" style="background: url(/eImage_files/Map5.png) center center / contain no-repeat; height: 75%; width: 20%; position: relative;">

                        <div class="login-container" style="width: 300px; background: #fff url('/eImage_files/background_logo.png') no-repeat center center; border-radius: 10px; padding: 20px 75px; margin-top: 50px; border: 1px solid #F4F4F4;">

                            <form runat="server" autocomplete="off" style="text-align: center;">
                                <div style="gap: 0.5vh; flex-direction: column; display: flex;">

                                    <p class="login-content-for-platform fs-20-vw fw-700">One Stop Platform Sign In for All Personas</p>
                                    <div class="input-group">
                                        <span class="fs-16-vw fw-500" style="color: rgb(33, 33, 33);">User ID*</span>
                                        <input type="text" name="email" placeholder="Enter User ID" id="txtUserName" runat="server" class="input-field " value="">
                                    </div>
                                    <div class="input-group">
                                        <span class="fs-16-vw fw-500" style="color: rgb(33, 33, 33);">Enter Password*</span><div class="password-wrapper">
                                            <input type="password" placeholder="Enter Password" id="txtPassword" runat="server" class="input-field " value="">
                                            <span id="togglePassword" class="toggle-password" onclick="if (txtPassword.type == 'text') txtPassword.type = 'password'; else txtPassword.type = 'text';" >

                                                <svg  stroke="currentColor" fill="currentColor" stroke-width="0" viewBox="0 0 576 512" height="1em" width="1em" xmlns="http://www.w3.org/2000/svg" style="color: rgb(0, 0, 0); font-size: 2vh;">
                                                    <path d="M572.52 241.4C518.29 135.59 410.93 64 288 64S57.68 135.64 3.48 241.41a32.35 32.35 0 0 0 0 29.19C57.71 376.41 165.07 448 288 448s230.32-71.64 284.52-177.41a32.35 32.35 0 0 0 0-29.19zM288 400a144 144 0 1 1 144-144 143.93 143.93 0 0 1-144 144zm0-240a95.31 95.31 0 0 0-25.31 3.79 47.85 47.85 0 0 1-66.9 66.9A95.78 95.78 0 1 0 288 160z"></path></svg></span>
                                        </div>
                                    </div>

                                    <asp:ScriptManager ID="ScriptManager1" runat="server" />
                                    <asp:UpdatePanel ID="upCaptcha" runat="server">
                                        <ContentTemplate>
                                            <div class="captcha-container" style="margin-left: 1%; width:70%;">
                                                <div style="display: flex; flex-direction: row; gap: 2vh;">

                                                    <asp:Image ID="imgCaptcha" runat="server" Style="display: inline-block;" />
                                                    <span class="captcha-contain" style="margin-left: 25%;">
                                                        <img src="\eimage_files\recaptcha.png" alt="Captcha" style="z-index: 10; width: 47px; display: inline-block; vertical-align: middle;" onclick="__doPostBack('<%= btnRefreshCaptcha.UniqueID %>', '')" />
                                                    </span>

                                                    <!-- Hidden Button to trigger CAPTCHA refresh -->
                                                    <asp:Button ID="btnRefreshCaptcha" runat="server" Style="display: none" OnClick="btnRefreshCaptcha_Click" />


                                                </div>
                                            </div>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>

                                    <div class="input-group">
                                        <span class="fs-16-vw fw-500" style="color: rgb(33, 33, 33);">CAPTCHA*</span>
                                        <asp:TextBox ID="txtCaptcha" Style="width: 100%;" runat="server" Placeholder="Enter CAPTCHA" CssClass="input-field"></asp:TextBox>
                                        <asp:RequiredFieldValidator
                                            ID="rfvtxtCaptcha"
                                            runat="server" ValidationGroup="OTP"
                                            ControlToValidate="txtCaptcha"
                                            ErrorMessage="Captcha is required"
                                            ForeColor="Red"
                                            Display="Dynamic" Style="font-size: x-small;" />
                                    </div>



                                    <div>
                                        <br />
                                    </div>
                                    <div class="links" style="display: none;"><span class="fs-14-vw fw-600">Forgot Password?</span></div>
                                    <%-- <button type="submit" id="submit" class="btn fs-22-vw fw-600" runat="server" onserverclick="submit_ServerClick">Continue</button>--%>
                                    <asp:Button ID="btnSubmit" class="btn fs-22-vw fw-600" runat="server" Text="Continue" OnClick="btnSubmit_Click" />
                                </div>
                            </form>
                            <br />

                            <br />
                            <center>
                                <div style="margin-top: 5%; width: 100%; text-align: left;">
                                    
                                        <div id="lblloginmsg" runat="server" class="my-notify-error" visible="false"></div>
                                    
                                </div>
                                <a href="Admin/FrmLicAct.aspx"></a>
                            </center>
                        </div>
                        <!--   <img src="eImage_files/govt_logo.png" alt="Government Logo" class="govt-logo-login">-->
                    </div>
                </div>
            </div>
            <div class="footer-container">
                <div class="fs-15-vw fw-500">
                    Copyright
                    <svg stroke="currentColor" fill="currentColor" stroke-width="0" viewBox="0 0 512 512" height="1em" width="1em" xmlns="http://www.w3.org/2000/svg">
                        <path d="M256 48a208 208 0 1 1 0 416 208 208 0 1 1 0-416zm0 464A256 256 0 1 0 256 0a256 256 0 1 0 0 512zM199.4 312.6c-31.2-31.2-31.2-81.9 0-113.1s81.9-31.2 113.1 0c9.4 9.4 24.6 9.4 33.9 0s9.4-24.6 0-33.9c-50-50-131-50-181 0s-50 131 0 181s131 50 181 0c9.4-9.4 9.4-24.6 0-33.9s-24.6-9.4-33.9 0c-31.2 31.2-81.9 31.2-113.1 0z"></path></svg>
                    2025 Nigeria Immigration Service. All Rights Reserved.
                </div>
            </div>
        </div>
        <div class="Toastify"></div>
    </div>
</body>
<merlin-component id="merlin-uicomponentportal" class="merlin merlin-uicomponentportal"></merlin-component>
</html>
