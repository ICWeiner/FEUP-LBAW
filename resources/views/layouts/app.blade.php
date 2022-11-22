<!DOCTYPE html>
<html lang="{{ app()->getLocale() }}">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- CSRF Token -->
    <meta name="csrf-token" content="{{ csrf_token() }}">

    <title>{{ config('app.name', 'Laravel') }}</title>

    <!-- Styles -->
    <link href="{{ asset('css/layout.css') }}" rel="stylesheet">
    <link href="{{ asset('css/app.css') }}" rel="stylesheet">
    <script type="text/javascript">
        // Fix for Firefox autofocus CSS bug
        // See: http://stackoverflow.com/questions/18943276/html-5-autofocus-messes-up-css-loading/18945951#18945951
    </script>
    <script type="text/javascript" src={{ asset('js/app.js') }} defer>
</script>
  </head>
  <body>
    <main>
      <header>

        <div class="hamburger-menu">
          <input id="menu__toggle" type="checkbox" />
          <label class="menu__btn" for="menu__toggle">
            <span></span>
          </label>

          <ul class="menu__box">
            <li><a class="menu__item" href="{{ url('/') }}">Home</a></li>
            <li>
              @if (Auth::check())
                <a href="{{ url('/user') }}"><span>{{ Auth::user()->name }}</span></a>
              @endif
            </li>
            <li>
              @if (Auth::check())
                <a class="menu_item" href="{{ url('/logout') }}">Logout</a>
              @endif
            <li>
                <a class="menu_item" href="{{ url('/cart') }}">Cart</a>
            </li>
          </ul>
        </div>

        <h1><a>ATGO</a></h1>

        <div class="search">
          <form action="/search" method="get">
            <input type="text" name="search" placeholder="Search...">
            <button type="submit">Go</button>
          </form>
        </div>

        @if (Auth::check())
        <!--<a href="{{ url('/user') }}"><span>{{ Auth::user()->name }}</span></a><a class="button" href="{{ url('/logout') }}"> Logout </a>--> 
        @endif
      </header>
      <section id="content">
        @yield('content')
      </section>
    </main>
      <footer>
        <h6><a href="{{ url('/about') }}">About</a></h6>
        <h6><a href="{{ url('/services') }}">Services</a></h6>
        <h6><a href="{{ url('/faq') }}">FAQ</a></h6>
        <h6><a href="{{ url('/contact') }}">Contact Us</a></h6>
      </footer>
  </body>
</html>
