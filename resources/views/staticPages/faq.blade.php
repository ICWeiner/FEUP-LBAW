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
            <button class="btn btn-link" data-toggle="collapse" data-target="#collapseOne" aria-expanded="false" aria-controls="collapseOne">
              How can I use MediaLibrary?
            </button>
          </h5>
        </div>

        <div id="collapseOne" class="collapse" aria-labelledby="headingOne" data-parent="#accordion">
          <div class="card-body">
            There are many ways you can use the media found on the MediaLibrary.
          </div>
        </div>
      </div>
      <div class="card mb-1">
        <div class="card-header" id="headingTwo">
          <h5 class="mb-0">
            <button class="btn btn-link collapsed" data-toggle="collapse" data-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
              What can I use the media for?
            </button>
          </h5>
        </div>
        <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#accordion">
          <div class="card-body">
            The media found on the Media Library can be used for a multitude of things.
            We suggest using it for enhancing lessons, sharing the items, deepening personal study, and enriching family home evenings.
          </div>
        </div>
      </div>
      <div class="card mb-1">
        <div class="card-header" id="headingThree">
          <h5 class="mb-0">
            <button class="btn btn-link collapsed" data-toggle="collapse" data-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree" style="white-space: normal;">
              Can found media in the MediaLibrary in a language other than English?
            </button>
          </h5>
        </div>
        <div id="collapseThree" class="collapse" aria-labelledby="headingThree" data-parent="#accordion">
          <div class="card-body">
            Yes! The MediaLibrary is also available in other languages. These information can be accessed in the specific item's page.
          </div>
        </div>
      </div>
      <div class="card mb-1">
        <div class="card-header" id="headingFour">
          <h5 class="mb-0">
            <button class="btn btn-link" data-toggle="collapse" data-target="#collapseFour" aria-expanded="false" aria-controls="collapseFour" style="white-space: normal;">
              How can I search just for images or videos?
            </button>
          </h5>
        </div>

        <div id="collapseFour" class="collapse" aria-labelledby="headingFour" data-parent="#accordion">
          <div class="card-body">
            If you search from the search menu on MediaLibrary there is an option on the left of the page to narrow your results to specific categories. Select the images or videos categories to narrow your results to either of those two categories.
          </div>
        </div>
      </div>
      <div class="card mb-1">
        <div class="card-header" id="headingFive">
          <h5 class="mb-0">
            <button class="btn btn-link collapsed" data-toggle="collapse" data-target="#collapseFive" aria-expanded="false" aria-controls="collapseFive" style="white-space: normal;">
              How do I borrow and renew materials?
            </button>
          </h5>
        </div>
        <div id="collapseFive" class="collapse" aria-labelledby="headingFive" data-parent="#accordion">
          <div class="card-body">
            To borrow items, choose them and check them are available to you.
            As long as no other library patron needs them, you can renew books several times. Use Log in to access your account. You will need your email and password.
            For more information, please see <a href="{{ URL::to('contact') }}">Contact</a>
          </div>
        </div>
      </div>
      <div class="card mb-1">
        <div class="card-header" id="headingSix">
          <h5 class="mb-0">
            <button class="btn btn-link collapsed" data-toggle="collapse" data-target="#collapseSix" aria-expanded="false" aria-controls="collapseSix">
              How can I return materials?
            </button>
          </h5>
        </div>
        <div id="collapseSix" class="collapse" aria-labelledby="headingSix" data-parent="#accordion">
          <div class="card-body">
            You are welcome to return most material to any reader. However, reserves loan items should be returned directly to the owner from which they were borrowed.
          </div>
        </div>
      </div>
      <div class="card mb-1">
        <div class="card-header" id="headingSeven">
          <h5 class="mb-0">
            <button class="btn btn-link collapsed" data-toggle="collapse" data-target="#collapseSeven" aria-expanded="false" aria-controls="collapseSeven" style="white-space: normal;">
              How do I get permission to publish materials?
            </button>
          </h5>
        </div>
        <div id="collapseSeven" class="collapse" aria-labelledby="headingSeven" data-parent="#accordion">
          <div class="card-body">
            Requests for permission to publish should be directed to the website. Any registered user can add items to MediaLibrary.
          </div>
        </div>
      </div>
    </div>
  </div>
@endsection
