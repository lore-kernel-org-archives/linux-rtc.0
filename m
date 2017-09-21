Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34026 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751728AbdIUW5h (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 21 Sep 2017 18:57:37 -0400
Date: Thu, 21 Sep 2017 17:57:35 -0500
From: Rob Herring <robh@kernel.org>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: fix vendor prefix for Abracon
Message-ID: <20170921225735.qkxpbjmiip5krhvw@rob-hp-laptop>
References: <20170914213938.4980-1-alexandre.belloni@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170914213938.4980-1-alexandre.belloni@free-electrons.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Thu, Sep 14, 2017 at 11:39:38PM +0200, Alexandre Belloni wrote:
> Commit 446810f2dd41 ("of: add vendor prefix for Abracon Corporation")
> claimed that "abcn" was used as the vendor prefix while in fact "abracon"
> was used in the subsequent commits. It is also the only prefix used in the
> tree.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied with alphabetical ordering fixed.

Rob
