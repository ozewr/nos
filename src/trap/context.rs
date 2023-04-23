use riscv::register::sstatus::{Sstatus, self, SPP};
pub struct  TrapContext {
    pub reg:[usize;32], // todo here sp,x1,x2...
    pub sstatus:Sstatus,
    pub sepc:usize,
}

impl TrapContext {
    pub fn set_sp(&mut self,sp:usize){
        self.reg[2] = sp ;
    }
    pub fn app_init_context(entry:usize ,sp:usize) -> Self {
        let mut sstatus = sstatus::read();
        sstatus.set_spp(SPP::User);
        let mut ctx = Self {
            reg:[0;32],
            sstatus,
            sepc:entry,
        };
        ctx.set_sp(sp);
        ctx
    }
}