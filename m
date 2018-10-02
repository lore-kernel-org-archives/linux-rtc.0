Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from eddie.linux-mips.org ([148.251.95.138]:34050 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbeJBHtL (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 2 Oct 2018 03:49:11 -0400
Date: Tue, 2 Oct 2018 02:08:37 +0100 (BST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] rtc: cmos: Fix non-ACPI (non-x86) platform support
Message-ID: <alpine.LFD.2.21.1810020122330.20762@eddie.linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Hi,

 This mini patch series fixes issues introduced recently for non-ACPI 
platforms using `rtc-cmos'.  Please see individual change descriptions for 
details.

 These have been run-time verified with the DECstation (arch/mips/dec).  
Please apply.

  Maciej
