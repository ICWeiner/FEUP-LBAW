@extends('layouts.app')

@section('title', $book->edition)

@section('content')
  @include('partials.book', ['book' => $book])
@endsection
