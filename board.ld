ENTRY(_start)
_base = 0x80000000; /* I'm not positive that this is right */
_stack_size = 1024;
_rom_size = 1024*1024;
_reset_vector = 0xBFC00000;

SECTIONS
{
	. = _base;
	.text :
	{
		*(.text*)
	}
	.data :
	{
		*(.data*)
	}
	.rodata : {
		*(.rodata*)
	}
	.gnu_build_id : {
		*(.note.gnu.build-id)
	}
	.stack (NOLOAD) :
	{
		_stack_top = .;
		. += _stack_size;
		_stack_bottom = .;
	}
	/DISCARD/ :
	{
		*.*
	}
}
