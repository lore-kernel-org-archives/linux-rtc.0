Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazolkn19011029.outbound.protection.outlook.com [52.103.32.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177361A9F8C;
	Sat,  5 Sep 2026 20:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.32.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788640920; cv=fail; b=n5yy0eIFxfORtvkqBAylPZeR6i+FnQ5hfssEfDjr6gBSHnAnVaBq2jj9NkVtavPF9qgscw9NaA8WXQ5pmo9r7JdD3qrq5ZZbNPuYtTZl4eA34zw9eGGfbarEOTDzrWVMcxqKg16ReAJSZXC5jVxMp3OVzI8Vlct8bFIwCEshGGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788640920; c=relaxed/simple;
	bh=REO1c2MVKoNaGdIJ8TpNyndPVXDIF0dJ5AZOvHmV9cY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Ep82JKpAuPSd6U3KPmOgs5RpGfjZIvKwq1zAd16lSuqkZ12PMq9QVfMmK9AgayxxoNORoAPo/oYdb09Z4B8NZ4ZWNdAMyKk0bSFjEImVfBYzObfv5aKEkUETjil437RGuH9zVyJoADTfILUk9pryItp8g8lqriti7mohMRSwOAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk; spf=pass smtp.mailfrom=hotmail.co.uk; dkim=pass (2048-bit key) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.b=EJ5yRDmk; arc=fail smtp.client-ip=52.103.32.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.b="EJ5yRDmk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K0SqvtXT3tYg6Ux6Qpaa0VtZ16BNxYnj3e1z0aEP0l+cMUs//IpyPtLTyiDdqtWuA9foT+OnL/Bcc6es3qTXG295tGSNKLAoyXO+q3DjjFUCxEb2TiWYrWenb94HkDwGJaAX0i2NRYShOjVELWVEDnGbT2s+pDqjGw5q2wQ5bROKUTkt2RYZhFiPOrx3qbxb24PUDQ/lTebgX2jabIXZeImr68mWElUIenTBdYWGyGiJTVBJiCqphBWxtFqRWIPrcVUpR7b1UYzpfbSYWtktgYpTcgcxV1T/gLDsMmVI5QcpbUANyJlk2XAVFw7cokGkJPh5w+0ftd5osk5u1AMhmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U6uCSuEvE0pzJzI+BBLFq+qLE0Cd7IhbPKaJAZIDiDE=;
 b=P9r6W+XYZcK5qIoUOURzd6WIPPadlMTg603zX9sldxROSqdd4/2q1NHPezYveMdDzt57F3GlVDzq5T8d8ETCXGbNiQdbaRMC+wR2bvXLWSrxCE0GUCm5GY8kjhkx8jy6tZm0V8qAeLXWrtDmf+yDnThX7Zu618ypK/g+36vxE/Iwvbw0XDV+WuPEB8B/msdkcLK10zPDsiVdsZMkwJBMj7EWnoBSn/N9gQdxeiG7OSKP1jabx92O7p3PLZPJxEJWbJ0oF7pxOEvVynoZtDdxvCipJNl/sV7sl9VdNHO86MnErArPMXUynBxL3pdPhclwmZlZ++Mk9eWCsKZhFMXByg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.CO.UK;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U6uCSuEvE0pzJzI+BBLFq+qLE0Cd7IhbPKaJAZIDiDE=;
 b=EJ5yRDmkIBpo93b7pYQfC+J+SuM6lef7vZEE+Zn4kooymQrVzI6ICz+yoeE6xjdEhUfflfxWiZkJ5PsCPJpk82LfngC9X7Bl0QsVmhVvZAupgtivE0QgHXaP9o6f8YQsSRij8I6UZ/YZKHt4xwVD/DM8mTg9M2hnUpoeyQs3SQh5HXyEgi4g7lmc4b6Jz14vTUaKJJe4kSe0Ho/IPuQVDZ14/5w2gx88GijD/V6rzOt96psGGH7oZiTWHoj5aodOCSGz0a3zuxbSYpNrqqS+kXaWEAmR3swhdSliaMdMJ3ddMt9OBgQoHSZVQeDa8B72FPSAIWCcN9m3wirZ1XBTaA==
Received: from AS8P251MB0001.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:344::22)
 by PA1PPF75DB7739D.EURP251.PROD.OUTLOOK.COM (2603:10a6:108:1::21b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Sat, 5 Sep
 2026 20:41:56 +0000
Received: from AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 ([fe80::2952:d4d0:4ba:8352]) by AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 ([fe80::2952:d4d0:4ba:8352%6]) with mapi id 15.21.0382.012; Sat, 5 Sep 2026
 20:41:55 +0000
From: Aamir Ahmed <elb12345@hotmail.co.uk>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen-Yu Tsai <wens@kernel.org>,
	linux-sunxi@lists.linux.dev,
	Aamir Ahmed <elb12345@hotmail.co.uk>,
	Sashiko AI <sashiko-bot@kernel.org>
Subject: [PATCH] rtc: ac100: Fix clock provider use-after-free on probe failure
Date: Sat,  5 Sep 2026 21:41:52 +0100
Message-ID:
 <AS8P251MB0001A489CC45A591ABBB9BDCC8B42@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0460.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1aa::15) To AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:344::22)
X-Microsoft-Original-Message-ID:
 <20260905204152.29971-1-elb12345@hotmail.co.uk>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P251MB0001:EE_|PA1PPF75DB7739D:EE_
X-MS-Office365-Filtering-Correlation-Id: fca5248b-67af-4657-c259-08df0b8e1fb3
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|24021099003|51005399006|5062599005|23021999003|5072599009|15080799012|25031999004|37011999003|41001999006|8060799015|19110799012|25010399006|40105399003|11031999003|12091999003|1602099012|10035399007|2607281247196008|3412199025|4302099013|440099028|26104999009|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kFcNcRD/mU7J/9USmYzfyFACBqsLPH4xLycxeJUatkvCTMhyhsyKSdWo5U8g?=
 =?us-ascii?Q?mC7XbgEdoXlN5PdvArOaESyoPfyhIgN0gfJU7r4Y88Uh98XLWcJSpuMw+WJ/?=
 =?us-ascii?Q?yz17a9cIjOBj64KED+rqdyG3xJijkWhvkEnDtWeDMeoemwiB2ly9vak6GBsG?=
 =?us-ascii?Q?att4akUhLnfbMnNft/s5xZKUzqGCpPmV+jyw0GCtoCm4IPuh5HqFeCwQNQqS?=
 =?us-ascii?Q?b9axrs4/08ShzZl7XYtaMCjSB3OBhgOJ7X1rvRAPgF5ODF8+Db3nlhdsRrKK?=
 =?us-ascii?Q?dgR469s6TbcwQOVHWLomvnpOBP8RWilBYkLb1vfVwkxKMTCNacxfTl9SvLJh?=
 =?us-ascii?Q?fIkyhj7xTWYZ335nzOEIHc1PL4+Qu5LM0UEZrD2QZwyg5XanQA31tux4uPoG?=
 =?us-ascii?Q?Yd1gFoSTvqqs5BeJfk1hbzwiFm9ky6F4Yyax12BPViFULS83dm42ymPNs1EC?=
 =?us-ascii?Q?ItrouHqgjw0fbI2yNHCUjp2DQv8QsRUtPF5ofTezJ7uxSpGE/bdXhjygoGXk?=
 =?us-ascii?Q?za7NdtdwaRN9jEG/SdoFIgXXMSoamKtai8v9s2nGsCQBm/1Fz4LMzmrzh6Dp?=
 =?us-ascii?Q?IlnTb6sDVHSJGJIVb5yHwt/bm6ZBjwcW2Pexuce2kkmHcvynTKfy28gzBcj4?=
 =?us-ascii?Q?5SE9gTrZtRzeEMb8eX/qv3C7zHFRZIraPb1D18Am0hfS5hqjd6AV/FON870b?=
 =?us-ascii?Q?V2yOy9PEw9ZaTCs0rhx0uBT6oh/nImr34lvk/Y0nQwgAdvTiOQkgyYeK/c9s?=
 =?us-ascii?Q?5ZUApxjiBzeVjdcNa/UV8OXvEwhnrr6ydyZsDo8dT0ALCI7a9IxfFfOMVQ6f?=
 =?us-ascii?Q?k6eMJU3aKg0EdrxIhHAXjDEcA9rJLqygGhW4tl07/OE2SLr1Wv2rrCP8MBBw?=
 =?us-ascii?Q?2Tb3VW2Hl4lsRoAEk8adusOK9ZgH6IxBm9ABCaiwfNS1DBnestDmM5xsSf8U?=
 =?us-ascii?Q?eKzOdYyKUfmVUqTuxJCHiPtMflY3/DCZAEgfW6szAlaCYqG6sQOvtA8Q//XV?=
 =?us-ascii?Q?knNeuqo0Di3+YUw/UwyDDZqN1E2PWi0jYj7AXAFcm1Axximl3JAxHeLE8Mjt?=
 =?us-ascii?Q?kSg1blKRHH9ejKN28hAwYYxNgCYigvqp8l1tG9fGzU6HVEtCxXv90KdoVJt2?=
 =?us-ascii?Q?m/REcQMFHvKEsR3d4wHnOahZam40tb120gQLb3kq8CoxO/oFsCY8fn0bGITO?=
 =?us-ascii?Q?710A2bPZJxjQfEszapg5g9WIn6QoqatAfYlVsTnIi9kHxajFf1Wzylc5eyd6?=
 =?us-ascii?Q?D835uY9un+soWPRQVcYY?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1yKYSHzvHeIpR3pLt6gGisiBH4RH1a2LYgIoH2ajEGATbiFzMAQs65j0UuG5?=
 =?us-ascii?Q?m6lJutMwcQAASefYgNVe9y5owFKiD0Qt87uqkKGTxS/7bsfg6w9bSaAaCjFJ?=
 =?us-ascii?Q?OriYEiQEboD1/gYwjQTgIRrQZsa8OZBlLeHEVGa0VNZV5uwj5ZD+kfowMtNW?=
 =?us-ascii?Q?2Z7vIecjBYru32J2Uq2brDHyAUzrFItagXsnAFPJWcMB0wUkDeXxtJHqXZt9?=
 =?us-ascii?Q?TpV3v0q8JMMPpiM6qo1Nq5ESi7xNE0oITzKtkdeqowcqFx3swA8QO6eqzUag?=
 =?us-ascii?Q?qsYnqoRTk3K4IH/gRZ50uvreU3HaF4R6cPLx/PYmRwpmFo+jAGW7GMAtY782?=
 =?us-ascii?Q?y+fu2BW4lNM4IVdU3eSXamoowG2u1kTG9aaitgxizu+DzuTAGpVyTCoSFEb3?=
 =?us-ascii?Q?gvq16i4pGea1hp3YEXDpgMelQtZhGYW0NzcmMMy0wdd2u+VAhO1ta1BCRaPP?=
 =?us-ascii?Q?3mqMmZJttLangBiT2ZSkW2TkLmT7PEVZbAGj41cJJPZtTjd1mNps+4XlrWrp?=
 =?us-ascii?Q?NCntjtQ+HKXY9jfPOKOSqgg4di++visSUrdnE55uG/6q9qdgVlaTKjsm3EaL?=
 =?us-ascii?Q?rSjdwL59hDBJ1cWEMcKIeVGC+Fd7uscMnbWqpbExTn9//NWBH/f0iJBhKGrg?=
 =?us-ascii?Q?IyyQRcrMDo90K/ncgk3ULRDAkEukdE64fo++DKUPl2kTQNnpdndPBzdPO3HJ?=
 =?us-ascii?Q?HnW/oj6Am+0V617dWDrlYPmj/ltLaJQIJcnjEhInQTftLt/fA9yfs6tc0bnw?=
 =?us-ascii?Q?iSA3Xv/1gPKTPx5M32GXO6qQf9k9ozVAeBbYuMJZplncsV7fXVjZRQcfZVUw?=
 =?us-ascii?Q?MjX2cH4fdLuwH41WAmxtzjMWzUHNn63Ilor9u4zEyM9MIyytOuDO1GLY6+Js?=
 =?us-ascii?Q?h9Kh97dglvD4e1C4PmkX1gaQEKPu9vVAP0y5NBGBMO7z3UAdJxkeynqb6c2b?=
 =?us-ascii?Q?3rOo/46AXqe1OhA2xmnBi1sgpeb2E6dk2yA+nhZg/uC1vHAsc9rlE0i//Bzr?=
 =?us-ascii?Q?I/Ha0W2S0yjFzfP56plN2/KESW7D3zjyutMKzqipzChXWo9Fyhl7Mvni3DoE?=
 =?us-ascii?Q?MdVWJmzJKUs0mc6tMUfUmLOflOpu1lQoofF1yDjzMGH7fAVPdMrE71UPfo0J?=
 =?us-ascii?Q?CX6OKIZHvKFzXYe1B/ze6z+ayu/9fX2djxLB65gTOEHLdiLoXM8Mtzl+L9XA?=
 =?us-ascii?Q?UIDdM/oRO+gUoaGyczCdKLi6z9e7xnWM0PZ3IucDdoK+L6da6Ol/e58UX5Tq?=
 =?us-ascii?Q?pOgvfG9UX/4mxI5aY6FG6owNoeAcw/UGfidhmeCZ+Jcsre+Y6T1Xw7yFteq8?=
 =?us-ascii?Q?jMhlNnuXAoKv2dIzE6kBbk+0sGbmiVJdtXYHCEhmbpAPEuQJZJlbyrNhS6GE?=
 =?us-ascii?Q?zF+eCXPJktMNVsjDNX0wO17NNYYjSGcXEF6l12p7PPQ0LRrXJT7wYFHn6c3Y?=
 =?us-ascii?Q?Q7jIIO9xUXpxoOfKfzwwggGGpolbbZqm?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-fe3f5.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: fca5248b-67af-4657-c259-08df0b8e1fb3
X-MS-Exchange-CrossTenant-AuthSource: AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2026 20:41:55.9197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PPF75DB7739D

ac100_rtc_register_clks() registers the RTC-32k clock with
clk_hw_register_fixed_rate() and the clock provider with
of_clk_add_hw_provider(). Neither is device managed, and both are
released only from ac100_rtc_remove(). The driver core does not call
remove() when probe() fails: really_probe() reaches probe_failed below
the device_remove() call and goes straight to releasing the device's
managed resources.

ac100_rtc_probe() ends with

	return devm_rtc_register_device(chip->rtc);

so if that fails after the clocks have been registered, the provider is
left on the global of_clk_providers list holding chip->clk_data, which
was allocated with devm_kzalloc() and is freed while probe() unwinds. A
later lookup on this device tree node then reads freed memory in
of_clk_hw_onecell_get(). Consumers that do exactly that exist in tree:
the wifi power sequence nodes on sun8i-a83t-bananapi-m3 and
sun8i-a83t-cubietruck-plus take <&ac100_rtc 1>, and the sun9i-a80 boards
route osc32k through <&ac100_rtc 0>. The window is narrow, as
devm_rtc_register_device() can only fail with -ENOMEM here, but the
provider is left dangling whenever it does.

The RTC-32k clock is leaked on the same path. Since clk_core_lookup()
searches a global list that is not scoped per device, __clk_register()
rejects the duplicate name with -EEXIST, so the leak also makes a later
probe of the same device fail.

The error path that returns -EINVAL when the ADDA 4M parent clock cannot
be found leaks the RTC-32k clock in the same way. No provider has been
registered at that point, so that one is a leak rather than a
use-after-free.

Register both with devm_clk_hw_register_fixed_rate() and
devm_of_clk_add_hw_provider() so that they are released whenever the
device goes away, on a failed probe as well as on unbind. Devres
releases in reverse order of acquisition, so the provider is removed
before chip->clk_data is freed, and the clkout children are now
unregistered before their parent rather than after it.
ac100_rtc_unregister_clks() and the remove callback then have nothing
left to do and are removed.

Fixes: d00a18a42c14 ("rtc: ac100: Add RTC driver for X-Powers AC100")
Reported-by: Sashiko AI <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/linux-rtc/20260905184936.155E11F00A3A@smtp.kernel.org/
Assisted-by: LLM
Signed-off-by: Aamir Ahmed <elb12345@hotmail.co.uk>
---
This applies on top of "[PATCH] rtc: ac100: Assign .num before accessing
.hws", posted to this list earlier today:

https://lore.kernel.org/linux-rtc/AS8P251MB00013E724A77A355668B6CCEC8B42@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM/

git format-patch emitted a prerequisite-patch-id for it below. I left
out the stable tag, both because the two live triggers are an order-0
allocation failure and a device tree that does not match the binding,
and because the merged fixes of this same shape carried a Fixes: tag
only: c7a639dac8e4 ("rtc: jz4740: Make sure clock provider gets
removed") and 9c48a5368504 ("rtc: pcf8563: fix clock provider leak on
unbind"). Happy to add it if you disagree.

On the choice of devm_of_clk_add_hw_provider(): it does not use
dev->of_node directly but goes through get_clk_provider_node(), which
substitutes the parent's node when the device's own node has no
#clock-cells. That substitution is inert here, since the binding
requires #clock-cells on the x-powers,ac100-rtc node and all six in-tree
boards set it, so the provider is still registered on the same node as
before.

The -EINVAL path is not reachable with any in-tree device tree: every
board gives the codec node clock-output-names and points the rtc node at
it, so of_clk_get_parent_name() always returns a name. It is fixed here
because the conversion covers it, not because I can trigger it.

The problem was pointed out by the Sashiko AI reviewer in reply to that
patch. I verified it against drivers/base/dd.c, drivers/clk/clk.c and
drivers/rtc/class.c before writing this.

chip->rtc_32k_clk is now only assigned and never read. Turning it into a
local and dropping the struct member would be a sensible follow-up, but
it is a separate cleanup so I left it out.

Compile-tested only (W=1, no warnings) on x86_64 with GCC 13.3, with
CONFIG_RTC_DRV_AC100=m forced on the make command line because the
driver has no COMPILE_TEST option. I do not have the hardware, so this
is not runtime-tested and neither error path was exercised. The fix and
this changelog were drafted with an LLM assistant and reviewed by hand.

 drivers/rtc/rtc-ac100.c | 36 +++++++-----------------------------
 1 file changed, 7 insertions(+), 29 deletions(-)

diff --git a/drivers/rtc/rtc-ac100.c b/drivers/rtc/rtc-ac100.c
index a2f465438fd..c579c4bf557 100644
--- a/drivers/rtc/rtc-ac100.c
+++ b/drivers/rtc/rtc-ac100.c
@@ -319,10 +319,10 @@ static int ac100_rtc_register_clks(struct ac100_rtc_dev *chip)
 
 	chip->clk_data->num = AC100_CLKOUT_NUM;
 
-	chip->rtc_32k_clk = clk_hw_register_fixed_rate(chip->dev,
-						       AC100_RTC_32K_NAME,
-						       NULL, 0,
-						       AC100_RTC_32K_RATE);
+	chip->rtc_32k_clk = devm_clk_hw_register_fixed_rate(chip->dev,
+							    AC100_RTC_32K_NAME,
+							    NULL, 0,
+							    AC100_RTC_32K_RATE);
 	if (IS_ERR(chip->rtc_32k_clk)) {
 		ret = PTR_ERR(chip->rtc_32k_clk);
 		dev_err(chip->dev, "Failed to register RTC-32k clock: %d\n",
@@ -356,28 +356,14 @@ static int ac100_rtc_register_clks(struct ac100_rtc_dev *chip)
 		if (ret) {
 			dev_err(chip->dev, "Failed to register clk '%s': %d\n",
 				init.name, ret);
-			goto err_unregister_rtc_32k;
+			return ret;
 		}
 
 		chip->clk_data->hws[i] = &clk->hw;
 	}
 
-	ret = of_clk_add_hw_provider(np, of_clk_hw_onecell_get, chip->clk_data);
-	if (ret)
-		goto err_unregister_rtc_32k;
-
-	return 0;
-
-err_unregister_rtc_32k:
-	clk_unregister_fixed_rate(chip->rtc_32k_clk->clk);
-
-	return ret;
-}
-
-static void ac100_rtc_unregister_clks(struct ac100_rtc_dev *chip)
-{
-	of_clk_del_provider(chip->dev->of_node);
-	clk_unregister_fixed_rate(chip->rtc_32k_clk->clk);
+	return devm_of_clk_add_hw_provider(chip->dev, of_clk_hw_onecell_get,
+					   chip->clk_data);
 }
 
 /*
@@ -615,13 +601,6 @@ static int ac100_rtc_probe(struct platform_device *pdev)
 	return devm_rtc_register_device(chip->rtc);
 }
 
-static void ac100_rtc_remove(struct platform_device *pdev)
-{
-	struct ac100_rtc_dev *chip = platform_get_drvdata(pdev);
-
-	ac100_rtc_unregister_clks(chip);
-}
-
 static const struct of_device_id ac100_rtc_match[] = {
 	{ .compatible = "x-powers,ac100-rtc" },
 	{ },
@@ -630,7 +609,6 @@ MODULE_DEVICE_TABLE(of, ac100_rtc_match);
 
 static struct platform_driver ac100_rtc_driver = {
 	.probe		= ac100_rtc_probe,
-	.remove		= ac100_rtc_remove,
 	.driver		= {
 		.name		= "ac100-rtc",
 		.of_match_table	= of_match_ptr(ac100_rtc_match),

base-commit: 654ae5d73c05bd2943d65636ce6cd0aa46e62f18
prerequisite-patch-id: 1474421ba7fe25ac3d750fdfdda9bd4209a85869
-- 
2.53.0.windows.1

