Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:35167 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755109AbdHYIeQ (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Fri, 25 Aug 2017 04:34:16 -0400
Date: Fri, 25 Aug 2017 10:34:15 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Cc: linux-mips@linux-mips.org,
        Aleksandar Markovic <aleksandar.markovic@imgtec.com>,
        Miodrag Dinic <miodrag.dinic@imgtec.com>,
        Goran Ferenc <goran.ferenc@imgtec.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Bo Hu <bohu@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org,
        Douglas Leung <douglas.leung@imgtec.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Hogan <james.hogan@imgtec.com>,
        Jin Qian <jinqian@google.com>, linux-kernel@vger.kernel.org,
        linux-rtc@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Paul Burton <paul.burton@imgtec.com>,
        Petar Jovanovic <petar.jovanovic@imgtec.com>,
        Raghu Gandham <raghu.gandham@imgtec.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v4 1/8] Documentation: Add device tree binding for
 Goldfish RTC driver
Message-ID: <20170825083415.vgrkd6sdltvrnty4@piout.net>
References: <1503061833-26563-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1503061833-26563-2-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1503061833-26563-2-git-send-email-aleksandar.markovic@rt-rk.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 18/08/2017 at 15:08:53 +0200, Aleksandar Markovic wrote:
> From: Aleksandar Markovic <aleksandar.markovic@imgtec.com>
> 
> Add documentation for DT binding of Goldfish RTC driver. The compatible
> string used by OS for binding the driver is "google,goldfish-rtc".
> 
> Signed-off-by: Miodrag Dinic <miodrag.dinic@imgtec.com>
> Signed-off-by: Goran Ferenc <goran.ferenc@imgtec.com>
> Signed-off-by: Aleksandar Markovic <aleksandar.markovic@imgtec.com>
> ---
>  .../devicetree/bindings/rtc/google,goldfish-rtc.txt     | 17 +++++++++++++++++
>  MAINTAINERS                                             |  5 +++++
>  2 files changed, 22 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rtc/google,goldfish-rtc.txt
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
