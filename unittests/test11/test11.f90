program Test11
	implicit none
	include 'cgnslib_f.h'

	integer:: fin, ier
	
	integer:: isize, jsize
	double precision, dimension(:,:), allocatable:: grid_x, grid_y

	double precision, dimension(:,:), allocatable:: result_real
	double precision, dimension(:), allocatable:: particlex, particley

	integer:: i, j, iter
	double precision:: t

	! CGNS �t�@�C���̃I�[�v��
	call cg_open_f('test.cgn', CG_MODE_MODIFY, fin, ier)
	if (ier /=0) STOP "*** Open error of CGNS file ***"

	! iRIClib �̏�����
	call cg_iric_init_f(fin, ier)
	if (ier /=0) STOP "*** Initialize error of CGNS file ***"

	! �i�q�̃T�C�Y�𒲂ׂ�
	call cg_iric_gotogridcoord2d_f(isize, jsize, ier)

	! �i�q��ǂݍ��ނ��߂̃��������m��
	allocate(grid_x(isize,jsize), grid_y(isize,jsize))
	! �i�q��ǂݍ���
	call cg_iric_getgridcoord2d_f(grid_x, grid_y, ier)

	if (ier /=0) STOP "*** No grid data ***"
	! �o��
	print *, 'grid x, y: isize, jsize=', isize, jsize
	do i = 1, isize
		do j = 1, jsize
			print *, '(', i, ', ', j, ') = (', grid_x(i, j), ', ', grid_y(i, j), ')'
		end do
	end do

	! allocate �Ŋm�ۂ������������J��
	deallocate(grid_x, grid_y)

	! �v�Z���ʂ��o��
	allocate(result_real(isize, jsize))
	allocate(particlex(10), particley(10))
	do i = 1, isize
		do j = 1, jsize
			result_real(i, j) = i * j
		end do
	end do
	do i = 1, 10
		particlex(i) = i
		particley(i) = 0
	end do
	do iter = 1, 5
		t = iter * 2.1
		call cg_iric_write_sol_time_f(t, ier)
		call cg_iric_write_sol_real_f('result_real', result_real, ier)
		call cg_iric_write_sol_particle_pos2d_f(iter, particlex, particley, ier)
	end do

	! CGNS �t�@�C���̃N���[�Y
	call cg_close_f(fin, ier)
	stop
end program Test11
