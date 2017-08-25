Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:35135 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932190AbdHYIeH (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Fri, 25 Aug 2017 04:34:07 -0400
Date: Fri, 25 Aug 2017 10:34:05 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Cc: linux-mips@linux-mips.org,
        Miodrag Dinic <miodrag.dinic@imgtec.com>,
        Goran Ferenc <goran.ferenc@imgtec.com>,
        Aleksandar Markovic <aleksandar.markovic@imgtec.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Bo Hu <bohu@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Douglas Leung <douglas.leung@imgtec.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Hogan <james.hogan@imgtec.com>,
        Jin Qian <jinqian@google.com>, linux-kernel@vger.kernel.org,
        linux-rtc@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Paul Burton <paul.burton@imgtec.com>,
        Petar Jovanovic <petar.jovanovic@imgtec.com>,
        Raghu Gandham <raghu.gandham@imgtec.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v4 2/8] rtc: goldfish: Add RTC driver for Android emulator
Message-ID: <20170825083405.7gy3mllefnwinaoc@piout.net>
References: <1503061833-26563-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1503061833-26563-3-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1503061833-26563-3-git-send-email-aleksandar.markovic@rt-rk.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 18/08/2017 at 15:08:54 +0200, Aleksandar Markovic wrote:
> From: Miodrag Dinic <miodrag.dinic@imgtec.com>
> 
> Add device driver for a virtual RTC device in Android emulator.
> 
> The compatible string used by OS for binding the driver is defined
> as "google,goldfish-rtc".
> 
> Signed-off-by: Miodrag Dinic <miodrag.dinic@imgtec.com>
> Signed-off-by: Goran Ferenc <goran.ferenc@imgtec.com>
> Signed-off-by: Aleksandar Markovic <aleksandar.markovic@imgtec.com>
> ---
>  MAINTAINERS                |   1 +
>  drivers/rtc/Kconfig        |   8 ++
>  drivers/rtc/Makefile       |   1 +
>  drivers/rtc/rtc-goldfish.c | 237 +++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 247 insertions(+)
>  create mode 100644 drivers/rtc/rtc-goldfish.c
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
