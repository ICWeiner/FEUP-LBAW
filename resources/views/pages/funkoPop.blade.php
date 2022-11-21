@extends('layouts.app')

@section('title', $funkoPop->number_pop)

@section('content')
  @include('partials.funkoPop', ['funkoPop' => $funkoPop])
@endsection
