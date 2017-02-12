Date: Sun, 12 Feb 2017 01:10:18 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: rtc-linux@googlegroups.com, alex@digriz.org.uk
Subject: Re: [rtc-linux] [PATCH 0/3] rtc: m48t86: cleanup driver and add
 NVRAM support
Message-ID: <20170212001018.r4x7mhzz5lol2ncu@piout.net>
References: <20170210181157.6283-1-hsweeten@visionengravers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170210181157.6283-1-hsweeten@visionengravers.com>
List-ID: <rtc-linux.googlegroups.com>

On 10/02/2017 at 11:11:54 -0700, H Hartley Sweeten wrote:
> This rtc driver is currently only used by the Technologic Systems TS-72xx
> (arm/mach-ep93xx) and TS-78xx (arm/mach-orion5x) SBCs. These platforms use
> static I/O mappings for the registers needed to access the index and data
> registers of the chip.
> 
> On the TS-78xx there is one I/O mapping of SZ_1M for the entire FPGA address
> space. The rtc index and data registers are located in that space along with
> all the other FPGA devices.
> 
> On the TS-72xx the mapping is a bit uglier. That platform uses a CPLD to
> access the rtc. The CPLD is connected to two chip select lines of the
> processor and each chip select addresses 256 MiB. Address lines 25-22 and 0
> are then decoded for the various devices. Since mapping the entire 256 MiB
> for each address space would be _really_ ugly, a SZ_4K mapping is done for
> each register that is needed.
> 
> This series does the following:
>  1) Cleanup this driver to remove all the checkpatch.pl issues.
>  2) Modify the probe to, optionally, ioremap the resources provided by the
>     platform and handle the read/write operations internally.
>  3) Add support for the NVRAM in the rtc.
> 
> With these changes the static I/O mappings for the rtc registers can be
> removed from the ts-72xx platform.
> 
> Currently the ts78xx platform does some "probing" of the rtc NVRAM to see
> if it is actually present before registering the rtc device. This "probing"
> just checks if the NVRAM is present by reading/writing the last two bytes
> of the NVRAM. I'm not sure if this is really necessary. If it can be removed
> all the m48t86_ops stuff could also be removed from this driver, along with
> platform_data/rtc-m48t86.h.
> 
> H Hartley Sweeten (3):
>   rtc: m48t86: shorten register name defines
>   rtc: m48t86: allow driver to manage it's resources
>   rtc: m48t86: add NVRAM support
> 
>  drivers/rtc/rtc-m48t86.c | 247 ++++++++++++++++++++++++++++++++---------------
>  1 file changed, 169 insertions(+), 78 deletions(-)
> 

All applied, thanks.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
