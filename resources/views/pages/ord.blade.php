@extends('layouts.app')

@section('title', $ord->id_ord)

@section('content')
  @include('partials.ord', ['ord' => $ord])
@endsection