@extends('layouts.app')

@section('title', $shoe->name)

@section('content')
  @include('partials.shoe', ['shoe' => $shoe])
@endsection
