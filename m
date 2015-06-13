Return-Path: <rtc-linux+bncBDS7HNEFSALRBUWR6CVQKGQETFENLGI@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id q10si233496wiz.0.2015.06.13.05.57.53
        for <rtc-linux@googlegroups.com>;
        Sat, 13 Jun 2015 05:57:53 -0700 (PDT)
Date: Sat, 13 Jun 2015 14:57:53 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: matt.fleming@intel.com, linux-efi@vger.kernel.org,
	James.Bottomley@hansenpartnership.com, roy.franz@linaro.org,
	leif.lindholm@linaro.org, Alessandro Zummo <a.zummo@towertech.it>,
	rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH v2] efi: rtc-efi: use correct EFI 'epoch'
Message-ID: <20150613125753.GJ3890@piout.net>
References: <1433762834-17961-1-git-send-email-ard.biesheuvel@linaro.org>
 <1433841335-10453-1-git-send-email-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1433841335-10453-1-git-send-email-ard.biesheuvel@linaro.org>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 09/06/2015 at 11:15:35 +0200, Ard Biesheuvel wrote :
> The rtc-efi driver declares that the EFI 'epoch' is 1/1/1998, but
> the UEFI spec does not define it at all. It does define a range of
> [1900, 9999] for the 'Year' member of the EFI_TIME struct, so let's
> use 1900 as the minimum year and not 1998.
> Also, move the validation of the year to the convert_from_efi_time()
> routine where all other EFI_TIME fields are validated as well.
> 
> This prevents rtc_read_time() failures when the RTC that backs the
> EFI time services is set to a date before 1998, e.g., when it has
> lost power.
> 
> This also optimizes the compute_wday() routine, by replacing the for
> loop with a simple arithmetic expression, and by reusing the yearday
> value that we need to compute anyway when populating the
> rtc_time::tm_yday field.
> 
> Cc: Alessandro Zummo <a.zummo@towertech.it>
> Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Cc: rtc-linux@googlegroups.com
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Applied, thanks.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

-- 
-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
