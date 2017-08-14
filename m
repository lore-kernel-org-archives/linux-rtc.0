Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mailapp01.imgtec.com ([195.59.15.196]:48268 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753144AbdHNMqD (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 14 Aug 2017 08:46:03 -0400
From: Aleksandar Markovic <Aleksandar.Markovic@imgtec.com>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
CC: "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Goran Ferenc <Goran.Ferenc@imgtec.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Bo Hu <bohu@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Douglas Leung <Douglas.Leung@imgtec.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Hogan <James.Hogan@imgtec.com>,
        Jin Qian <jinqian@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        Paul Burton <Paul.Burton@imgtec.com>,
        "Petar Jovanovic" <Petar.Jovanovic@imgtec.com>,
        Raghu Gandham <Raghu.Gandham@imgtec.com>,
        Miodrag Dinic <Miodrag.Dinic@imgtec.com>,
        Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Subject: RE: [PATCH v3 2/8] MIPS: ranchu: Add Goldfish RTC driver
Date: Mon, 14 Aug 2017 12:45:55 +0000
Message-ID: <EF5FA6C3467F85449672C3E735957B85015D9CC3E1@BADAG02.ba.imgtec.org>
References: <1500656111-9520-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1500656111-9520-3-git-send-email-aleksandar.markovic@rt-rk.com>,<20170810203430.zgtxvi7uaqmg4dzr@piout.net>,<232DDC0A2B605E4F9E85F6904417885F015D937238@BADAG02.ba.imgtec.org>
In-Reply-To: <232DDC0A2B605E4F9E85F6904417885F015D937238@BADAG02.ba.imgtec.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Hello, Alexandre,

In addition, if you, and everybody else, don't object, I plan to change the title of this patch form:

"MIPS: ranchu: Add Goldfish RTC driver"

to

"rtc: Add Goldfish RTC driver",

to be more consistent with all commit messages for this kernel source directory.

Regards,
Aleksandar

________________________________________
From: Miodrag Dinic
Sent: Friday, August 11, 2017 9:46 AM
To: Alexandre Belloni; Aleksandar Markovic
Cc: linux-mips@linux-mips.org; Goran Ferenc; Aleksandar Markovic; Alessandro Zummo; Bo Hu; David S. Miller; Douglas Leung; Greg Kroah-Hartman; James Hogan; Jin Qian; linux-kernel@vger.kernel.org; linux-rtc@vger.kernel.org; Mauro Carvalho Chehab; Paul Burton; Petar Jovanovic; Raghu Gandham
Subject: RE: [PATCH v3 2/8] MIPS: ranchu: Add Goldfish RTC driver

Hi Alexandre,

we have this sorted & plan to submit version 4 of this series next week.

Thank you.

Kind regards,
Miodrag
________________________________________
From: Alexandre Belloni [alexandre.belloni@free-electrons.com]
Sent: Thursday, August 10, 2017 10:34 PM
To: Aleksandar Markovic
Cc: linux-mips@linux-mips.org; Miodrag Dinic; Goran Ferenc; Aleksandar Markovic; Alessandro Zummo; Bo Hu; David S. Miller; Douglas Leung; Greg Kroah-Hartman; James Hogan; Jin Qian; linux-kernel@vger.kernel.org; linux-rtc@vger.kernel.org; Mauro Carvalho Chehab; Paul Burton; Petar Jovanovic; Raghu Gandham
Subject: Re: [PATCH v3 2/8] MIPS: ranchu: Add Goldfish RTC driver

Hi,

On 21/07/2017 at 18:53:31 +0200, Aleksandar Markovic wrote:
> From: Miodrag Dinic <miodrag.dinic@imgtec.com>
>
> Add device driver for a virtual Goldfish RTC clock.
>
> The driver can be built only if CONFIG_MIPS and CONFIG_GOLDFISH are
> set. The compatible string used by OS for binding the driver is
> defined as "google,goldfish-rtc".
>
> Signed-off-by: Miodrag Dinic <miodrag.dinic@imgtec.com>
> Signed-off-by: Goran Ferenc <goran.ferenc@imgtec.com>
> Signed-off-by: Aleksandar Markovic <aleksandar.markovic@imgtec.com>
> ---
>  MAINTAINERS                |   1 +
>  drivers/rtc/Kconfig        |   8 ++
>  drivers/rtc/Makefile       |   1 +
>  drivers/rtc/rtc-goldfish.c | 233 +++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 243 insertions(+)
>  create mode 100644 drivers/rtc/rtc-goldfish.c
>

Do you mind fixing the remaining checkpatch --strict issues, the two
kbuild errors and the warning reported by Julia?

Thanks!


--
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
