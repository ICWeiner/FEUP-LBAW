@extends('layouts.app')

@section('content')
  <div class="container">

    <nav aria-label="breadcrumb">
      <ol class="breadcrumb mt-3">
        <li class="breadcrumb-item"><a href="{{ URL::to('/') }}">Home</a></li>
        <li class="breadcrumb-item active" aria-current="page">About</li>
      </ol>
    </nav>
    <h1 class="mt-3">About</h1>
    <hr>

    <section class="py-3">
      <div class="row">
        <div class="col-md-6">
          <h2>About ATGO</h2>
          <p>The main goal for this project being developed by a small indie company, akin to something like amazon and other online shopping websites,
             is to deliver a web-based information system focused on the cataloging and selling of books, shoes, Knick knacks and any other similarly
             sorted items and collectables. As such, we intend to have any number of users be able to access the catalogs for any of those items, check
             their availability and if they’re so incline to, buy any number of said items. </p>
        </div>
      </div>
    </section>

    <section class="pb-3">
      <h2 class="my-3">Our Team</h2>
      <hr>
      <div class="row text-center py-3">
        <div class="col-md-4 d-flex justify-content-center">
          <div class="card text-center" style="width: 14rem;">
            <div class="card-body">
            <img src="images/nunes.png  " alt="Generic placeholder image" class="img-fluid img-thumbnail mt-4 mb-2" style="width: 150px; z-index: 1">
              <h5 class="card-title">Diogo Nunes</h5>
              <p class="card-text">Main Back-End, copy-paste Front-end, from Lisbon and also wears googles</p>
            </div>
          </div>
        </div>
        <div class="col-md-4 d-flex justify-content-center">
          <div class="card" style="width: 14rem;">
            <div class="card-body">
            <img src="images/almeida.jpg  " alt="Generic placeholder image" class="img-fluid img-thumbnail mt-4 mb-2" style="width: 150px; z-index: 1">
              <h5 class="card-title">Diogo Almeida</h5>
              <p class="card-text">Back-End and front-end helper and has very cool kicks</p>
            </div>
          </div>
        </div>
        <div class="col-md-4 d-flex justify-content-center">
          <div class="card" style="width: 14rem;">
            <div class="card-body">
            <img src="images/rafa.png  " alt="Generic placeholder image" class="img-fluid img-thumbnail mt-4 mb-2" style="width: 150px; z-index: 1">
              <h5 class="card-title">Rafael Morgado</h5>
              <p class="card-text">Front-End, very tall and also from Lisbon</p>
            </div>
          </div>
        </div>
      </div>

      <div class="row text-center pb-3 justify-content-center">
        <div class="col-md-4 d-flex justify-content-center">
          <div class="card text-center" style="width: 14rem;">
            <div class="card-body">
            <img src="images/xico.png  " alt="Generic placeholder image" class="img-fluid img-thumbnail mt-4 mb-2" style="width: 150px; z-index: 1">
              <h5 class="card-title">Francisco Nunes</h5>
              <p class="card-text">Back-End Search engine developer</p>
            </div>
          </div>
        </div>
      </div>
@endsection
