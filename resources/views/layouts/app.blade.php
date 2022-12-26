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
    <link href="{{ asset('css/bootstrap.css') }}" rel="stylesheet">
    <link href="{{ asset('css/style.css') }}" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
    <script type="text/javascript">
        // Fix for Firefox autofocus CSS bug
        // See: http://stackoverflow.com/questions/18943276/html-5-autofocus-messes-up-css-loading/18945951#18945951
    </script>
    <script type="text/javascript" src={{ asset('js/app.js') }} defer>
    </script>
    <script type="text/javascript" src={{ asset('js/cart.js') }} defer>
    </script>
    <script src="https://kit.fontawesome.com/42e31a210b.js" crossorigin="anonymous">
    </script>
    <script type="text/javascript" src={{ asset('js/prodPage.js') }} defer>
    </script>
  </head>
  <body class="d-flex flex-column min-vh-100">
    <main>
      <header>
        <nav class="navbar navbar-expand-lg">
          <div class="container-fluid text-warningZ">
            <a class="navbar-brand text-warning " href="{{url('/')}}">ATGO</a>
            <button class="navbar-toggler border-1 btn-outline-warning text-warning" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
              <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
              <ul class="navbar-nav me-auto mb-2 mb-lg-0 ">
                @if (Auth::check())
                    <li class="nav-item">
                      <a class="nav-link active text-warning" href="{{ url('/user') }}"><span>{{ Auth::user()->name }}</span></a>
                    </li>
                @endif
                <li class="nav-item dropdown">
                  <a class="nav-link dropdown-toggle dropdown-outline-warning text-warning" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                    Products
                  </a>
                  <ul class="dropdown-menu" style="background-color: #f8f9fa;">
                    <li><a class="dropdown-item text-warning" href="{{ url('/products/shoes') }}">Shoes</a></li>
                    <li><a class="dropdown-item text-warning" href="{{ url('/products/books') }}">Books</a></li>
                    <li><a class="dropdown-item text-warning" href="{{ url('/products/funkoPops') }}">FunkoPops</a></li>
                  </ul>
                </li>
                @if (Auth::check())
                <li class="nav-item">
                  <a class="nav-link active text-warning" href="{{ url('/cart') }}">Cart</a>
                </li>
                  @else
                  <li clss="nav-item">
                  <a class="nav-link disabled text-warning" href="{{ url('/cart') }}">Cart</a>
                  </li>
                @endif
                @if (Auth::check())
                <li class="nav-item">
                  <a class="nav-link active text-warning" href="{{ url('/wishlist') }}">Wishlist</a>
                </li>
                  @else
                  <li clss="nav-item">
                  <a class="nav-link disabled text-warning" href="{{ url('/wishlist') }}">Wishlist</a>
                  </li>
                @endif
                @if (Auth::check())
                <li class="nav-item">
                  <a class="nav-link active text-warning" href="{{ url('/logout') }}">Logout</a>
                </li>
                  @else
                  <li class="nav-item">
                  <a class="nav-link active text-warning" href="{{ url('/login') }}">Login</a>
                  </li>
                @endif
              </ul>
              <form class="d-flex" role="search" action="/search" method="get">
                <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
                <button class=" search btn btn-outline-warning text-white" type="submit">Search</button>
              </form>
            </div>
          </div>
        </nav>
      </header>
        <section id="content">
          @yield('content')
        </section>
    </main>
        <footer class="text-center text-lg-start text-muted mt-auto" style="background-color: rgba(0, 0, 0, 0.05);">
          <section class="">
            <div class="container text-center ">
              <div class="d-flex flex-row justify-content-between align-items-center">
                <div class="col-md-2 col-lg-2 col-xl-2 mx-auto ">
                  <h6 class="text-uppercase fw-bold " style="margin:auto">
                    <a href="{{ url('/faq') }}" style="margin:auto">FAQ</a>
                  </h6>
                </div>
                <div class="col-md-2 col-lg-2 col-xl-2 mx-auto ">
                  <h6 class="text-uppercase fw-bold ">
                    <a href="{{ url('/about') }}">About</a>
                  </h6>
                </div>
                <div class="col-md-2 col-lg-2 col-xl-2 mx-auto mb-md-0">
                  <h6 class="text-uppercase fw-bold ">
                    <a href="{{ url('/contact') }}">Contact Us</a>
                  </h6>
                </div>
              </div>
            </div>
          </section>
          <div class="text-center p-4" style="background-color: rgba(0, 0, 0, 0.05);">
            © 2023 Copyright:
            <a class="text-reset fw-bold">LBAW2292</a>
          </div>
        </footer>
      <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js" integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3" crossorigin="anonymous"></script>
      <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.min.js" integrity="sha384-cuYeSxntonz0PPNlHhBs68uyIAVpIIOZZ5JqeqvYYIcEL727kskC66kF92t6Xl2V" crossorigin="anonymous"></script>
    </body>
</html>
