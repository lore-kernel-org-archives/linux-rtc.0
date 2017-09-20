Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35107 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751897AbdITUwY (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 20 Sep 2017 16:52:24 -0400
Date: Wed, 20 Sep 2017 15:52:22 -0500
From: Rob Herring <robh@kernel.org>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Anatolij Gustschin <agust@denx.de>,
        linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/3] RTC: rv3029: fix vendor string
Message-ID: <20170920205222.u445mraruddz3ufl@rob-hp-laptop>
References: <20170915020004.24272-1-alexandre.belloni@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170915020004.24272-1-alexandre.belloni@free-electrons.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Fri, Sep 15, 2017 at 04:00:02AM +0200, Alexandre Belloni wrote:
> The vendor string for Microcrystal is microcrystal.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>  Documentation/devicetree/bindings/trivial-devices.txt | 2 +-
>  drivers/rtc/rtc-rv3029c2.c                            | 2 ++
>  2 files changed, 3 insertions(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>
