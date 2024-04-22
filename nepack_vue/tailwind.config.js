/** @type {import('tailwindcss').Config} */
export default {
  content: [
    "./index.html",
    "./src/**/*.{vue,js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {
      screens: {
        'ssm': '400px',
      },
      fontFamily: {
        Karla: ["Karla", "sans-serif"],
      },
      colors: {
        'light-coffee': '#C89F94',
        'best-product': '#dadada',
        'bgdark': '#171923',
        'bgform': '#252A37',
      },
      keyframes: {
        slideRight: {
          '0%': {
            transform: 'translateX(-100%)',
          },
          '100%': {
            transform: 'translateX(100%)',
          },
        },
        fadeIn: {
          '0%': {
            opacity: 0,
          },
          '100%': {
            opacity: 1,
          },
        },
        slideDown: {
          '0%': {
            transform: 'translateY(-100%)',
          },
          '100%': {
            transform: 'translateY(0)',
          },
        },
        slideDown2: {
          '0%': {
            transform: 'translateY(-100%)',
          },
          '100%': {
            transform: 'translateY(-40%)',
          },
        },
        moveUpDown: {
          '0%': {
            transform: 'translateY(0)',
          },
          '100%': {
            transform: 'translateY(-10%)',
          },
        },
      },
      animation: {
        slideDown: 'slideDown .5s ',
        slideDown2: 'slideDown2 0.9s infinite alternate',
        moveUpDown: 'moveUpDown 0.8s infinite alternate',
        slideRight: 'slideRight 40s linear infinite',
        fadeIn: 'fadeIn 1s ease-in-out',
      },
    },
  },

  plugins: [
    function ({addUtilities}) {
      const newUtilities = {
        ".no-scrollbar::-webkit-scrollbar": {
          display: "none",
        },
        ".no-scrollbar": {
          "-ms-overflow-style": "none",
          "scrollbar-width": "none",	
        }
      }
      addUtilities(newUtilities)
    }
  ],
}

