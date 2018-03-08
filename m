Return-Path: <Alexander.Levin@microsoft.com>
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Hans de Goede <hdegoede@redhat.com>, "rtc-linux@googlegroups.com"
	<rtc-linux@googlegroups.com>, "alexandre.belloni@free-electrons.com"
	<alexandre.belloni@free-electrons.com>, Sasha Levin
	<Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 09/53] x86: i8259: export legacy_pic symbol
Date: Thu, 8 Mar 2018 05:03:09 +0000
Message-ID: <20180308050230.8876-9-alexander.levin@microsoft.com>
References: <20180308050230.8876-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050230.8876-1-alexander.levin@microsoft.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <rtc-linux.googlegroups.com>

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 7ee06cb2f840a96be46233181ed4557901a74385 ]

The classic PC rtc-coms driver has a workaround for broken ACPI device
nodes for it which lack an irq resource. This workaround used to
unconditionally hardcode the irq to 8 in these cases.

This was causing irq conflict problems on systems without a legacy-pic
so a recent patch added an if (nr_legacy_irqs()) guard to the
workaround to avoid this irq conflict.

nr_legacy_irqs() uses the legacy_pic symbol under the hood causing
an undefined symbol error if the rtc-cmos code is build as a module.

This commit exports the legacy_pic symbol to fix this.

Cc: rtc-linux@googlegroups.com
Cc: alexandre.belloni@free-electrons.com
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/x86/kernel/i8259.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/i8259.c b/arch/x86/kernel/i8259.c
index e7cc5370cd2f..6c7e7986939a 100644
--- a/arch/x86/kernel/i8259.c
+++ b/arch/x86/kernel/i8259.c
@@ -405,6 +405,7 @@ struct legacy_pic default_legacy_pic =3D {
 };
=20
 struct legacy_pic *legacy_pic =3D &default_legacy_pic;
+EXPORT_SYMBOL(legacy_pic);
=20
 static int __init i8259A_init_ops(void)
 {
--=20
2.14.1
