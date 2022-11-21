@extends('layouts.app')

@section('content')
  <div class="container">

    <nav aria-label="breadcrumb">
      <ol class="breadcrumb mt-3">
        <li class="breadcrumb-item"><a href="{{ URL::to('/') }}">Home</a></li>
        <li class="breadcrumb-item active" aria-current="page">Contact Us</li>
      </ol>
    </nav>
    <h1 class="my-3">Contact Us</h1>
    <hr>

    <!-- Content Row -->
    <div class="row pb-3">
      <!-- Map Column -->
      <div class="col-md-8">
        <!-- Embedded Google Map -->
        <iframe width="100%" height="400px" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" src="https://maps.google.com/maps?hl=en&amp;ie=UTF8&amp;ll=41.177967,-8.5960284&amp;t=m&amp;z=15&amp;output=embed"></iframe>
      </div>
      <!-- Contact Details Column -->
      <div class="col-md-4">
        <h3>Contact details</h3>
        <p>
          Faculdade de Engenharia (FEUP)<br>Rua Dr. Roberto Frias<br>4200-465 PORTO<br>
        </p>
        <p><i class="fa fa-phone"></i>
          <abbr title="Phone"></abbr> (+351) 22 508 14 00</p>
        <p><i class="fa fa-envelope"></i>
          <abbr title="Email"></abbr> <a href="mailto:feup@fe.up.pt">feup@fe.up.pt</a>
        </p>
        <p><i class="fa fa-clock"></i>
          <abbr title="Hours"></abbr> Monday - Sunday: 24h</p>
        <ul class="list-inline">
          <li class="list-inline-item">
            <a href="https://www.facebook.com/paginafeup"><i class="fab fa-facebook fa-2x"></i></a>
          </li>
          <li class="list-inline-item">
            <a href="https://www.linkedin.com/school/6498?pathWildcard=6498"><i class="fab fa-linkedin fa-2x"></i></a>
          </li>
          <li class="list-inline-item">
            <a href="https://www.linkedin.com/school/6498?pathWildcard=6498"><i class="fab fa-twitter fa-2x"></i></a>
          </li>
          <li class="list-inline-item">
            <a href="https://www.instagram.com/feup_porto/"><i class="fab fa-instagram fa-2x"></i></a>
          </li>
        </ul>
      </div>
    </div>
  </div>
@endsection
