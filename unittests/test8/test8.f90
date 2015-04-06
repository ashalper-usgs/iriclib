program Test8
	implicit none
	include 'cgnslib_f.h'

	integer:: fin1, fin2, ier
	
	integer:: isize, jsize
	double precision, dimension(:,:), allocatable:: grid_x, grid_y
	double precision, dimension(:,:), allocatable:: result_real

	integer:: i, j, solid, solcount, iter
	double precision:: t

	! CGNS �t�@�C���̃I�[�v��
	call cg_open_f('test.cgn', CG_MODE_MODIFY, fin1, ier)
	if (ier /=0) STOP "*** Open error of CGNS file ***"
	call cg_open_f('result.cgn', CG_MODE_READ, fin2, ier)

	! iRIClib �̏�����
	call cg_iric_init_f(fin1, ier)
	! �i�q���Ȃ��̂Ŏ��s����
	call cg_iric_initread_f(fin2, ier)
	if (ier /=0) STOP "*** Initialize error of CGNS file2 ***"

	! �i�q�̃T�C�Y�𒲂ׂ�
	call cg_iric_gotogridcoord2d_mul_f(fin2, isize, jsize, ier)

	! �i�q��ǂݍ��ނ��߂̃��������m��
	allocate(grid_x(isize,jsize), grid_y(isize,jsize))
	! �i�q��ǂݍ���
	call cg_iric_getgridcoord2d_mul_f(fin2, grid_x, grid_y, ier)

	if (ier /=0) STOP "*** No grid data ***"

	! �i�q����������
	call cg_iric_writegridcoord2d_mul_f(fin1, isize, jsize, grid_x, grid_y, ier)
	if (ier /=0) STOP "*** No grid data ***"


	call cg_iric_read_sol_count_mul_f(fin2, solcount, ier)

	! �v�Z���ʂ�����
	allocate(result_real(isize, jsize))
	do solid = 1, solcount
		! �v�Z���ʂ�ǂݍ���
		call cg_iric_read_sol_iteration_mul_f(fin2, solid, iter, ier)
		call cg_iric_read_sol_gridcoord2d_mul_f(fin2, solid, grid_x, grid_y, ier)
		call cg_iric_read_sol_real_mul_f(fin2, solid, 'result_real', result_real, ier)

		call cg_iric_write_sol_iteration_mul_f(fin1, iter * 2, ier)
		grid_x = grid_x * 2
		grid_y = grid_y * 2
		result_real = result_real * 2.5
		call cg_iric_write_sol_gridcoord2d_mul_f(fin1, grid_x, grid_y, ier)
		call cg_iric_write_sol_real_mul_f(fin1, 'result_real', result_real, ier)
	end do

	! CGNS �t�@�C���̃N���[�Y
	call cg_close_f(fin1, ier)
	call cg_close_f(fin2, ier)
	stop
end program Test8
