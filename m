Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4421833A00C;
	Mon, 14 Sep 2026 21:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789420853; cv=none; b=hfREgwEMRn5jzwYdaYwiw4xmgCW8t2LHcIJso9SiPr4gFi6bm/T2fjsVMEHsYerZW5TcHH43eEYkB0N/iTp5CBdMAwm3lT3E8eCcHdodrqqolUqy5IYUBqAkmclkevGaJhyeIeV1YTZxMkuXKCmI8+ZELozkNFxEQQSOL4qR4fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789420853; c=relaxed/simple;
	bh=2H5syE67OIonLRXl1f6hju4squF9vzYlVrkBtAYZqYo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qaryZvRSK0K09HyfzSfX8K/RAcqsC9Iasag/7bj07Pt7yvIPELMQUKjAcxGGINQZyARzxu66e7i7nJ+RWMJ0a00KuwiCfD7Cu87sI1UzBSgCvGln47qof2qEEXiWSUrKhMQ3OuLPodmQbn6AEUX9L/DcuScb31cElXqhGNlay7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V7ms/bUC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V7ms/bUC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6215C1F000FF;
	Mon, 14 Sep 2026 21:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789420851;
	bh=2H5syE67OIonLRXl1f6hju4squF9vzYlVrkBtAYZqYo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V7ms/bUCk2ylOsZBlT4ERY9hahZmzjbXxH5VFm/ruLJ0aAkm8To6vQP7TRRKM5xkV
	 o3IKUu8cLj46Ut7Xx1lotLKbYoHpIc2y6SGhIjYSmTjSTSMSk39ghT/vQSZ8UUcBQl
	 otb92b35A4/kT6k9IgjOSu+MVtobVf7lscPFdQp7ieR8dvExQBxlMKgo6SD1YxGbxE
	 WsAxyrRIGaU3vIpJjV8DdNYvdnyX02/zMevMRlvA4d6MTFEy5O4dnOAjy3tCVfJx12
	 qPMVR/7amhdpvJZMKdLJZiKcEvEkm9Hp8HuKPokExJSjqXqChA7UyYY9g9RDXUEhWO
	 iV2KF4lWnxjTw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/6] dt-bindings: rtc: rzn1: add SoC names next to their
 IDs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wolfram Sang" <wsa+renesas@sang-engineering.com>
Cc: robh@kernel.org, wsa+renesas@sang-engineering.com, linux-rtc@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, conor+dt@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260914211826.73727-10-wsa+renesas@sang-engineering.com>
References: <20260914211826.73727-8-wsa+renesas@sang-engineering.com>
 <20260914211826.73727-10-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 21:20:50 +0000
Message-Id: <20260914212051.6215C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> This helps maintaining because the numbers are easy to confuse.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914211826.7372=
7-8-wsa+renesas@sang-engineering.com?part=3D2

