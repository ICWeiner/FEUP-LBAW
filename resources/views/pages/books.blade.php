@extends('layouts.app')

@section('title', 'Store')

@section('content')

<section id="books">
  @each('partials.book', $books, 'book')
  <article class="book">
  </article>
</section>

@endsection
