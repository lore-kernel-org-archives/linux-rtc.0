Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-yw0-f194.google.com ([209.85.161.194]:36271 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932217AbdGJOIx (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 10 Jul 2017 10:08:53 -0400
Date: Mon, 10 Jul 2017 09:08:50 -0500
From: Rob Herring <robh@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-rtc@vger.kernel.org,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH] rtc: ds1307: remove legacy check for
 "isil,irq2-can-wakeup-machine" property
Message-ID: <20170710140850.zqddgr2gy6gn3zpx@rob-hp-laptop>
References: <ff4ea92b-4af3-1a59-2ea3-056a43125c20@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ff4ea92b-4af3-1a59-2ea3-056a43125c20@gmail.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Thu, Jul 06, 2017 at 10:40:03PM +0200, Heiner Kallweit wrote:
> Commit 8b44f5be20fd ("ARM: dts: armada: replace isil,irq2-can-wakeup-machine with wakeup-source property")
> removed the last usage of "isil,irq2-can-wakeup-machine" almost
> two years ago. So I think we can get rid of supporting this
> legacy binding.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  Documentation/devicetree/bindings/power/wakeup-source.txt | 9 ++++-----
>  Documentation/devicetree/bindings/rtc/isil,isl12057.txt   | 1 -
>  drivers/rtc/rtc-ds1307.c                                  | 8 +-------
>  3 files changed, 5 insertions(+), 13 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
