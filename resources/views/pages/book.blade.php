@extends('layouts.app')

@section('title', $book->name)

@section('content')
  @include('partials.book', ['book' => $book])
@endsection
