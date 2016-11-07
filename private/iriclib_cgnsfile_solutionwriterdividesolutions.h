#ifndef IRICLIB_CGNSFILE_SOLUTIONWRITERDIVIDESOLUTIONS_H
#define IRICLIB_CGNSFILE_SOLUTIONWRITERDIVIDESOLUTIONS_H

#include "iriclib_cgnsfile_solutionwriter.h"

namespace iRICLib {

class CgnsFile::SolutionWriterDivideSolutions : public CgnsFile::SolutionWriter
{
public:
	SolutionWriterDivideSolutions(CgnsFile::Impl* impl);

	int Sol_Write_Time(double time) override;
	int Sol_Write_Iteration(int index) override;
	int Sol_Write_GridCoord2d(double *x, double *y) override;
	int Sol_Write_GridCoord3d(double *x, double *y, double *z) override;
	int Sol_Write_Integer(const char *name, int* data) override;
	int Sol_Write_Real(const char *name, double* data) override;

	int Flush() override;
};

} // namespace iRICLib

#endif // IRICLIB_CGNSFILE_SOLUTIONWRITERDIVIDESOLUTIONS_H
