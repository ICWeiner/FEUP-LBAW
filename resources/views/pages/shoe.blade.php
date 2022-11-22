@extends('layouts.app')

@section('title', $shoe->id_product)

@section('content')
  @include('partials.shoe', ['shoe' => $shoe])
@endsection
