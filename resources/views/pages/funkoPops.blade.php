@extends('layouts.app')

@section('title', 'Store')

@section('content')

<section id="funkoPops">
  @each('partials.funkoPop', $funkoPops, 'funkoPop')
  <article class="funkoPop">
  </article>
</section>

@endsection
