Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBBOEXLEQKGQECO4ASDI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id 196si520976wma.3.2017.05.31.03.59.17
        for <rtc-linux@googlegroups.com>;
        Wed, 31 May 2017 03:59:17 -0700 (PDT)
Date: Wed, 31 May 2017 12:59:06 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Alessandro Zummo <a.zummo@towertech.it>,
	linuxppc-dev@lists.ozlabs.org, rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH] rtc/tpo: Handle disabled TPO in opal_get_tpo_time()
Message-ID: <20170531105906.7ldsv6wa5ezmbjre@piout.net>
References: <20170519100509.7807-1-vaibhav@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
In-Reply-To: <20170519100509.7807-1-vaibhav@linux.vnet.ibm.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 19/05/2017 at 15:35:09 +0530, Vaibhav Jain wrote:
> On PowerNV platform when Timed-Power-On(TPO) is disabled, read of
> stored TPO yields value with all date components set to '0' inside
> opal_get_tpo_time(). The function opal_to_tm() then converts it to an
> offset from year 1900 yielding alarm-time == "1900-00-01
> 00:00:00". This causes problems with __rtc_read_alarm() that
> expecting an offset from "1970-00-01 00:00:00" and returned alarm-time
> results in a -ve value for time64_t. Which ultimately results in this
> error reported in kernel logs with a seemingly garbage value:
> 
> "rtc rtc0: invalid alarm value: -2-1--1041528741
> 2005511117:71582844:32"
> 
> We fix this by explicitly handling the case of all alarm date-time
> components being '0' inside opal_get_tpo_time() and returning -ENOENT
> in such a case. This signals generic rtc that no alarm is set and it
> bails out from the alarm initialization flow without reporting the
> above error.
> 
> Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
> Reported-by: Steve Best <sbest@redhat.com>
> ---
>  drivers/rtc/rtc-opal.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
