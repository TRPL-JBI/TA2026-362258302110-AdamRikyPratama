{{-- resources/views/user/selesai/index.blade.php --}}

@extends('layouts.app') {{-- Sesuaikan dengan layout utama Anda --}}

@section('content')
<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card border-0 shadow-sm">
                <div class="card-body p-5 text-center">

                    {{-- ================================================= --}}
                    {{-- KASUS 1: MENUNGGU VERIFIKASI (Pending) --}}
                    {{-- ================================================= --}}
                    @if($verifikasi && $verifikasi->status == 'Menunggu Verifikasi')

                        <div class="mb-4 text-warning">
                            <i class="fas fa-clock fa-5x"></i>
                        </div>
                        <h3 class="fw-bold text-dark">Sedang Dalam Proses Verifikasi</h3>
                        <p class="text-muted mt-3">
                            Data organisasi Anda telah berhasil kami terima. <br>
                            Saat ini Admin sedang melakukan peninjauan data.
                        </p>
                        <div class="alert alert-warning mt-4 d-inline-block text-start">
                            <small><i class="fas fa-info-circle me-1"></i> <strong>Note:</strong> Proses ini biasanya memakan waktu 1x24 jam kerja. Silakan cek halaman ini secara berkala.</small>
                        </div>
                        <div class="mt-4">
                            <a href="{{ route('user.dashboard') }}" class="btn btn-outline-secondary">
                                <i class="fas fa-home me-2"></i> Kembali ke Dashboard
                            </a>
                        </div>


                    {{-- ================================================= --}}
                    {{-- KASUS 2: DITOLAK (Perlu Revisi) --}}
                    {{-- ================================================= --}}
                    @elseif($verifikasi && $verifikasi->status == 'Ditolak')

                        <div class="mb-4 text-danger">
                            <i class="fas fa-exclamation-circle fa-5x"></i>
                        </div>
                        <h3 class="fw-bold text-danger">Pengajuan Perlu Revisi</h3>
                        <p class="text-muted mt-3">
                            Mohon maaf, data Anda belum dapat disetujui karena terdapat kekurangan atau kesalahan.
                        </p>

                        {{-- Tampilkan Catatan Admin --}}
                        @if($verifikasi->catatan)
                            <div class="alert alert-danger mt-3 text-start">
                                <strong><i class="fas fa-clipboard-list me-2"></i> Catatan Admin:</strong><br>
                                {{ $verifikasi->catatan }}
                            </div>
                        @endif

                        <div class="mt-4">
                            {{-- Tombol ini mengarah kembali ke form daftar untuk edit --}}
                            <a href="{{ route('user.daftar.index') }}" class="btn btn-warning px-4 fw-bold">
                                <i class="fas fa-edit me-2"></i> Perbaiki Data Sekarang
                            </a>
                        </div>


                    {{-- ================================================= --}}
                    {{-- KASUS 3: DISETUJUI (Approved / Allow) --}}
                    {{-- ================================================= --}}
                    @elseif($verifikasi && $verifikasi->status == 'Approved')

                        <div class="mb-4 text-success">
                            <i class="fas fa-check-circle fa-5x"></i>
                        </div>
                        <h3 class="fw-bold text-success">Verifikasi Berhasil!</h3>
                        <p class="text-muted mt-3">
                            Selamat! Organisasi Anda telah resmi terdaftar dan terverifikasi. <br>
                            Anda sekarang dapat mengakses fitur penuh dan mencetak Kartu Induk Kesenian.
                        </p>

                        <div class="mt-4 d-flex justify-content-center gap-2">
                            <a href="{{ route('user.dashboard') }}" class="btn btn-primary px-4">
                                <i class="fas fa-tachometer-alt me-2"></i> Dashboard
                            </a>
                            {{-- Jika ada fitur cetak kartu --}}
                            {{-- <a href="#" class="btn btn-outline-success px-4">
                                <i class="fas fa-print me-2"></i> Cetak Kartu
                            </a> --}}
                        </div>


                    {{-- ================================================= --}}
                    {{-- KASUS DEFAULT (Belum ada data verifikasi) --}}
                    {{-- ================================================= --}}
                    @else

                        <div class="mb-4 text-primary">
                            <i class="fas fa-file-alt fa-5x"></i>
                        </div>
                        <h3 class="fw-bold">Belum Ada Pengajuan</h3>
                        <p class="text-muted mt-3">
                            Sepertinya Anda belum mengirimkan data pengajuan. <br>
                            Silakan lengkapi form pendaftaran terlebih dahulu.
                        </p>
                        <div class="mt-4">
                            <a href="{{ route('user.daftar.index') }}" class="btn btn-primary px-4">
                                <i class="fas fa-pen me-2"></i> Isi Formulir
                            </a>
                        </div>

                    @endif

                </div>
            </div>
        </div>
    </div>
</div>
@endsection
