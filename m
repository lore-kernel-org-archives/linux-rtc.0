Return-Path: <rtc-linux+bncBDJ4N37Q6EERBNVI467AKGQEIQEAZ7Q@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mga03.intel.com (mga03.intel.com. [134.134.136.65])
        by gmr-mx.google.com with ESMTPS id h124si1643363pfe.0.2016.09.14.15.50.29
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 14 Sep 2016 15:50:29 -0700 (PDT)
Date: Thu, 15 Sep 2016 06:49:25 +0800
From: kbuild test robot <lkp@intel.com>
To: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Cc: kbuild-all@01.org, alexandre.belloni@free-electrons.com,
	a.zummo@towertech.it, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org, matthew.garrett@nebula.com,
	Gabriele Mazzotta <gabriele.mzt@gmail.com>
Subject: [rtc-linux] Re: [PATCH v3 1/2] rtc-cmos: Clear ACPI-driven alarms
 upon resume
Message-ID: <201609150628.A4BEDg4u%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="gKMricLos+KVdGMg"
In-Reply-To: <20160914190841.10684-1-gabriele.mzt@gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

Hi Gabriele,

[auto build test WARNING on abelloni/rtc-next]
[also build test WARNING on v4.8-rc6 next-20160914]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
[Suggest to use git(>=2.9.0) format-patch --base=<commit> (or --base=auto for convenience) to record what (public, well-known) commit your patch series was built on]
[Check https://git-scm.com/docs/git-format-patch for more information]

url:    https://github.com/0day-ci/linux/commits/Gabriele-Mazzotta/rtc-cmos-Clear-ACPI-driven-alarms-upon-resume/20160915-031802
base:   https://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git rtc-next
config: i386-randconfig-x0-09150359 (attached as .config)
compiler: gcc-6 (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All warnings (new ones prefixed by >>):

   In file included from include/linux/linkage.h:4:0,
                    from include/linux/kernel.h:6,
                    from drivers/rtc/rtc-cmos.c:34:
   drivers/rtc/rtc-cmos.c: In function 'cmos_resume':
   drivers/rtc/rtc-cmos.c:941:9: error: 'acpi_gbl_FADT' undeclared (first use in this function)
          !(acpi_gbl_FADT.flags & ACPI_FADT_FIXED_RTC)) {
            ^
   include/linux/compiler.h:149:30: note: in definition of macro '__trace_if'
     if (__builtin_constant_p(!!(cond)) ? !!(cond) :   \
                                 ^~~~
>> drivers/rtc/rtc-cmos.c:940:3: note: in expansion of macro 'if'
      if ((tmp & RTC_AIE) &&
      ^~
   drivers/rtc/rtc-cmos.c:941:9: note: each undeclared identifier is reported only once for each function it appears in
          !(acpi_gbl_FADT.flags & ACPI_FADT_FIXED_RTC)) {
            ^
   include/linux/compiler.h:149:30: note: in definition of macro '__trace_if'
     if (__builtin_constant_p(!!(cond)) ? !!(cond) :   \
                                 ^~~~
>> drivers/rtc/rtc-cmos.c:940:3: note: in expansion of macro 'if'
      if ((tmp & RTC_AIE) &&
      ^~
   drivers/rtc/rtc-cmos.c:941:31: error: 'ACPI_FADT_FIXED_RTC' undeclared (first use in this function)
          !(acpi_gbl_FADT.flags & ACPI_FADT_FIXED_RTC)) {
                                  ^
   include/linux/compiler.h:149:30: note: in definition of macro '__trace_if'
     if (__builtin_constant_p(!!(cond)) ? !!(cond) :   \
                                 ^~~~
>> drivers/rtc/rtc-cmos.c:940:3: note: in expansion of macro 'if'
      if ((tmp & RTC_AIE) &&
      ^~
   drivers/rtc/rtc-cmos.c:942:4: error: unknown type name 'acpi_status'
       acpi_status status;
       ^~~~~~~~~~~
   drivers/rtc/rtc-cmos.c:943:4: error: unknown type name 'acpi_event_status'
       acpi_event_status rtc_status;
       ^~~~~~~~~~~~~~~~~
   drivers/rtc/rtc-cmos.c:945:13: error: implicit declaration of function 'acpi_get_event_status' [-Werror=implicit-function-declaration]
       status = acpi_get_event_status(ACPI_EVENT_RTC,
                ^~~~~~~~~~~~~~~~~~~~~
   drivers/rtc/rtc-cmos.c:945:35: error: 'ACPI_EVENT_RTC' undeclared (first use in this function)
       status = acpi_get_event_status(ACPI_EVENT_RTC,
                                      ^~~~~~~~~~~~~~
   In file included from include/linux/linkage.h:4:0,
                    from include/linux/kernel.h:6,
                    from drivers/rtc/rtc-cmos.c:34:
   drivers/rtc/rtc-cmos.c:947:8: error: implicit declaration of function 'ACPI_FAILURE' [-Werror=implicit-function-declaration]
       if (ACPI_FAILURE(status)) {
           ^
   include/linux/compiler.h:149:30: note: in definition of macro '__trace_if'
     if (__builtin_constant_p(!!(cond)) ? !!(cond) :   \
                                 ^~~~
   drivers/rtc/rtc-cmos.c:947:4: note: in expansion of macro 'if'
       if (ACPI_FAILURE(status)) {
       ^~
   drivers/rtc/rtc-cmos.c:949:28: error: 'ACPI_EVENT_FLAG_SET' undeclared (first use in this function)
       } else if (rtc_status & ACPI_EVENT_FLAG_SET) {
                               ^
   include/linux/compiler.h:149:30: note: in definition of macro '__trace_if'
     if (__builtin_constant_p(!!(cond)) ? !!(cond) :   \
                                 ^~~~
   drivers/rtc/rtc-cmos.c:949:11: note: in expansion of macro 'if'
       } else if (rtc_status & ACPI_EVENT_FLAG_SET) {
              ^~
   In file included from include/acpi/acpi.h:64:0,
                    from include/linux/acpi.h:33,
                    from drivers/rtc/rtc-cmos.c:987:
   include/acpi/acpixf.h: At top level:
   include/acpi/acpixf.h:705:5: error: conflicting types for 'acpi_get_event_status'
        acpi_get_event_status(u32 event,
        ^
   include/acpi/acpixf.h:95:2: note: in definition of macro 'ACPI_EXTERNAL_RETURN_STATUS'
     prototype;
     ^~~~~~~~~
   include/acpi/acpixf.h:704:1: note: in expansion of macro 'ACPI_HW_DEPENDENT_RETURN_STATUS'
    ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/rtc/rtc-cmos.c:945:13: note: previous implicit declaration of 'acpi_get_event_status' was here
       status = acpi_get_event_status(ACPI_EVENT_RTC,
                ^~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +/if +940 drivers/rtc/rtc-cmos.c

   924				CMOS_WRITE(tmp, RTC_CONTROL);
   925				hpet_set_rtc_irq_bit(tmp & RTC_IRQMASK);
   926	
   927				mask = CMOS_READ(RTC_INTR_FLAGS);
   928				mask &= (tmp & RTC_IRQMASK) | RTC_IRQF;
   929				if (!is_hpet_enabled() || !is_intr(mask))
   930					break;
   931	
   932				/* force one-shot behavior if HPET blocked
   933				 * the wake alarm's irq
   934				 */
   935				rtc_update_irq(cmos->rtc, 1, mask);
   936				tmp &= ~RTC_AIE;
   937				hpet_mask_rtc_irq_bit(RTC_AIE);
   938			} while (mask & RTC_AIE);
   939	
 > 940			if ((tmp & RTC_AIE) &&
   941			    !(acpi_gbl_FADT.flags & ACPI_FADT_FIXED_RTC)) {
   942				acpi_status status;
   943				acpi_event_status rtc_status;
   944	
   945				status = acpi_get_event_status(ACPI_EVENT_RTC,
   946							       &rtc_status);
   947				if (ACPI_FAILURE(status)) {
   948					dev_err(dev, "Could not get RTC status\n");

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.

--gKMricLos+KVdGMg
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--gKMricLos+KVdGMg--
