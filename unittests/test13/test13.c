#include "cgnslib.h"
#include <iriclib.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(int argc, char* argv) {
	int fin, ier;
	int locked;
	int canceled;
	char* fname = "test.cgn";
	printf("HELLO\n");

	// CGNS �t�@�C���̃I�[�v��
	ier = cg_open(fname, CG_MODE_MODIFY, &fin);
	if (ier != 0){
		printf("*** Open error of CGNS file ***\n");
		return 1;
	}

	// iRIClib �̏�����
	ier = cg_iRIC_Init(fin);

	cg_close(fin);

	// Cancel �ɑΉ����Ă��邱�Ƃ�ʒm
	ier = iRIC_InitOption(IRIC_OPTION_CANCEL);

/*
	// ���ʂ̏������݂��J�n
	ier = iRIC_Write_Sol_Start(fname);
	printf("iRIC_Write_Sol_Start: %d", ier);

	// ���ʂ̏������݂��I��
	ier = iRIC_Write_Sol_End(fname);
	printf("iRIC_Write_Sol_End: %d", ier);
*/
	// ���b�N����Ă��邩���m�F
	locked = iRIC_Check_Lock(fname);

	// �L�����Z������Ă��邩���m�F
	canceled = iRIC_Check_Cancel();

	return 0;
}
