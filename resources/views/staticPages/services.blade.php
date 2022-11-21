@extends('layouts.app')

@section('content')
  <div class="container">

    <nav aria-label="breadcrumb">
      <ol class="breadcrumb mt-3">
        <li class="breadcrumb-item"><a href="{{ URL::to('/') }}">Home</a></li>
        <li class="breadcrumb-item active" aria-current="page">Services</li>
      </ol>
    </nav>
    <h1 class="my-3">Services</h1>
    <hr>

    <div class="row pb-3">
      <div class="col-md-3 col-sm-6 d-flex justify-content-center">
        <div class="card text-center" style="width: 14rem;">
          <div class="card-header">
          <span class="fa-stack fa-5x">
            <i class="fa fa-circle fa-stack-2x text-default"></i>
            <i class="fa fa-book fa-stack-1x fa-inverse"></i>
          </span>
          </div>
          <div class="card-body">
            <h4 class="card-text">Books</h4>
          </div>
        </div>
      </div>

      <div class="col-md-3 col-sm-6 d-flex justify-content-center">
        <div class="card text-center" style="width: 14rem;">
          <div class="card-header">
          <span class="fa-stack fa-5x">
            <i class="fa fa-circle fa-stack-2x text-default"></i>
            <i class="fa fa-music fa-stack-1x fa-inverse"></i>
          </span>
          </div>
          <div class="card-body">
            <h4 class="card-text">Musics</h4>
          </div>
        </div>
      </div>


      <div class="col-md-3 col-sm-6 d-flex justify-content-center">
        <div class="card text-center" style="width: 14rem;">
          <div class="card-header">
          <span class="fa-stack fa-5x">
            <i class="fa fa-circle fa-stack-2x text-default"></i>
            <i class="fa fa-book fa-stack-1x fa-inverse"></i>
          </span>
          </div>
          <div class="card-body">
            <h4 class="card-text">Videos</h4>
          </div>
        </div>
      </div>

      <div class="col-md-3 col-sm-6 d-flex justify-content-center">
        <div class="card text-center" style="width: 14rem;">
          <div class="card-header">
          <span class="fa-stack fa-5x">
            <i class="fa fa-circle fa-stack-2x text-default"></i>
            <i class="fa fa-camera fa-stack-1x fa-inverse"></i>
          </span>
          </div>
          <div class="card-body">
            <h4 class="card-text">Photos</h4>
          </div>
        </div>
      </div>

    </div>

    <section class="pb-3">
      <h2 class="my-3">Services list</h2>
      <hr>
      <div class="row align-items-center">
        <div class="col-md-4">
          <div class="media">
            <div class="pull-left pr-2">
            <span class="fa-stack fa-2x">
              <i class="fa fa-circle fa-stack-2x text-default"></i>
              <i class="fa fa-book fa-stack-1x fa-inverse"></i>
            </span>
            </div>
            <div class="media-body">
              <h4 class="media-heading">Books</h4>
              <p>Book loan process allows for the purchase of your books at the website.</p>
            </div>
          </div>
          <div class="media">
            <div class="pull-left pr-2">
            <span class="fa-stack fa-2x">
              <i class="fa fa-circle fa-stack-2x text-default"></i>
              <i class="fa fa-video fa-stack-1x fa-inverse"></i>
            </span>
            </div>
            <div class="media-body">
              <h4 class="media-heading">Video</h4>
              <p>The video file can be in DVD or VHS. Video loan process allows for the purchase of your videos at the website.</p>
            </div>
          </div>
        </div>
        <div class="col-md-4">
          <div class="media">
            <div class="pull-left pr-2">
            <span class="fa-stack fa-2x">
              <i class="fa fa-circle fa-stack-2x text-default"></i>
              <i class="fa fa-camera fa-stack-1x fa-inverse"></i>
            </span>
            </div>
            <div class="media-body">
              <h4 class="media-heading">Photos</h4>
              <p>Photo loan process allows for the purchase of your photos at the website.</p>
            </div>
          </div>
          <div class="media">
            <div class="pull-left pr-2">
            <span class="fa-stack fa-2x">
              <i class="fa fa-circle fa-stack-2x text-default"></i>
              <i class="fa fa-file-powerpoint fa-stack-1x fa-inverse"></i>
            </span>
            </div>
            <div class="media-body">
              <h4 class="media-heading">Slides</h4>
              <p>Slides loan process allows for the purchase of your slides at the website.</p>
            </div>
          </div>
        </div>
        <div class="col-md-4">
          <div class="media">
            <div class="pull-left pr-2">
            <span class="fa-stack fa-2x">
              <i class="fa fa-circle fa-stack-2x text-default"></i>
              <i class="fa fa-music fa-stack-1x fa-inverse"></i>
            </span>
            </div>
            <div class="media-body">
              <h4 class="media-heading">Music</h4>
              <p>The music file can be in MP3 or CD. Music loan process allows for the purchase of your music at the website.</p>
            </div>
          </div>
          <div class="media">
            <div class="pull-left pr-2">
            <span class="fa-stack fa-2x">
              <i class="fa fa-circle fa-stack-2x text-default"></i>
              <i class="fa fa-user fa-stack-1x fa-inverse"></i>
            </span>
            </div>
            <div class="media-body">
              <h4 class="media-heading">Users</h4>
              <p>This website also allow a secure and modern user management system.</p>
            </div>
          </div>
        </div>
      </div>
    </section>
  </div>
@endsection
