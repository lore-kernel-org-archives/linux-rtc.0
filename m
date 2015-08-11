Date: Tue, 11 Aug 2015 20:01:44 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Sylvain Chouleur <sylvain.chouleur@intel.com>
Cc: rtc-linux@googlegroups.com
Subject: Re: [rtc-linux] [PATCH] Support of century in rtc-cmos
Message-ID: <20150811180144.GV3411@piout.net>
References: <87lhfur0sw.fsf@schouleu-mobl1.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87lhfur0sw.fsf@schouleu-mobl1.ger.corp.intel.com>
List-ID: <rtc-linux.googlegroups.com>

On 08/06/2015 at 11:45:19 +0200, Sylvain Chouleur wrote :
> If century field is supported by the RTC CMOS device, then we should use
> it and then do not consider years greater that 169 as an error.
> 
> For information, the year field of the rtc_time structure contains the
> value to add to 1970 to obtain the current year.
> 
> This was a hack to be able to support years for 1970 to 2069.
> This patch remains compatible with this implementation.
> 
> Change-Id: I24af7eabf8efc9043092ad04e61ba69cb761000e
> Signed-off-by: Sylvain Chouleur <sylvain.chouleur@intel.com>
> ---
>  include/asm-generic/rtc.h | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
