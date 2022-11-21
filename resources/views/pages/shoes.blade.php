@extends('layouts.app')

@section('title', 'Store')

@section('content')

<section id="shoes">
  @each('partials.shoes', $shoes, 'shoe')
  <article class="shoe">
  </article>
</section>

@endsection
