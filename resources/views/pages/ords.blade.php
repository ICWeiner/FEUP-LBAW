@extends('layouts.app')

@section('title', 'Store')

@section('content')

<section id="ords">
  @each('partials.ords', $ords, 'ord')
  <article class="ords">
  </article>
</section>

@endsection
