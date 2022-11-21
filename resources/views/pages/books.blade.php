@extends('layouts.app')

@section('title', 'Store')

@section('content')

<section id="books">
  @each('partials.books', $books, 'book')
  <article class="book">
  </article>
</section>

@endsection
