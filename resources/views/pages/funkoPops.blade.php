@extends('layouts.app')

@section('title', 'Store')

@section('content')

<section id="funkoPops">
  @each('partials.funkoPops', $funkoPops, 'funkoPop')
  <article class="funkoPop">
  </article>
</section>

@endsection
