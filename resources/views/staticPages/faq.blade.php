@extends('layouts.app')

@section('content')
  <div class="container">

    <nav aria-label="breadcrumb">
      <ol class="breadcrumb mt-3">
        <li class="breadcrumb-item"><a href="{{ URL::to('/') }}">Home</a></li>
        <li class="breadcrumb-item active" aria-current="page">FAQ</li>
      </ol>
    </nav>
    <h1 class="my-3">FAQ</h1>
    <hr>

    <div id="accordion" class="pb-3">
      <div class="card mb-1">
        <div class="card-header" id="headingOne">
          <h5 class="mb-0">
            <p class="btn btn-link" style="text-decoration:none; color:black"> How can I use All Things Good Online? </p>
            <br>
            <p class="btn btn-link" style="text-decoration:none; color:black; margin-bottom:0px;"> To purchase on All Good Things Online just create an account, add the products you desire to the cart and proceed to the checkout page.</p>
          </h5>
        </div>
      </div>
      <div class="card mb-1">
        <div class="card-header" id="headingTwo">
          <h5 class="mb-0">
            <p class="btn btn-link" style="text-decoration:none; color:black"> What can I use the site for? </p>
            <br>
            <p class="btn btn-link" style="text-decoration:none; color:black; margin-bottom:0px;"> We suggest using it for browsing, searching and purchasing different items that you like. </p>
          </h5>
        </div>
      </div>
      <div class="card mb-1">
        <div class="card-header" id="headingThree">
          <h5 class="mb-0">
            <p class="btn btn-link" style="text-decoration:none; color:black"> Can All Things Good Online be in a language other than English? </p>
            <br>
            <p class="btn btn-link" style="text-decoration:none; color:black; margin-bottom:0px;"> We suggest using the browser translator as for now there is no other language. </p>
          </h5>
        </div>
      </div>
      <div class="card mb-1">
        <div class="card-header" id="headingFour">
          <h5 class="mb-0">
            <p class="btn btn-link" style="text-decoration:none; color:black"> How can I search just for a specific product? </p>
            <br>
            <p class="btn btn-link" style="text-decoration:none; color:black; margin-bottom:0px;"> You can use the search functionality at the top of any page or you can use the various categories to look for a specific product and also observe some similar to it. </p>
          </h5>
        </div>
      </div>
      <div class="card mb-1">
        <div class="card-header" id="headingFive">
          <h5 class="mb-0">
            <p class="btn btn-link" style="text-decoration:none; color:black"> How can I purchase an item? </p>
            <br>
            <p class="btn btn-link" style="text-decoration:none; color:black; margin-bottom:0px;"> You can purchase as many products you want as long they are in stock and you have an account for the website. </p>
          </h5>
        </div>
      </div>
      <div class="card mb-1">
        <div class="card-header" id="headingSix">
          <h5 class="mb-0">
            <p class="btn btn-link" style="text-decoration:none; color:black"> How can I give a review on an item? </p>
            <br>
            <p class="btn btn-link" style="text-decoration:none; color:black; margin-bottom:0px;"> You may only review items that you have bought with your account. </p>
          </h5>
        </div>
      </div>
    </div>
  </div>
@endsection
