Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81C535F16C;
	Fri, 21 Aug 2026 21:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787347045; cv=none; b=j3QMn9p6PePIimi/sJzHPc4HYKBKqY2ivFYeYoN1+wYNpyp8IVQCfqAo159Ez8ndd+drVW83z5FUSZYj3Fkz4kJVocheiBoNhB9aAlz+it36UncEWbCPFEtqFHO19ga9w07LyAm17g5Lqi0Hm/XiSpPJk9aY+X6kGhOt6sBQM9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787347045; c=relaxed/simple;
	bh=c3REpKxy5hSEi3uTP0B5G0MEOE+lmHStZ74kAZLp1A8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FAFGjDjTHdZ6o9ScU0kM2E6ZmMAUm1h/uevOE2Py5VLOBMjZfzk8TJm1akV156vAoYxLpmwcaf+IITbfclVDNB9U3MAa9yp/HJB8KG58tJ3/iazvsRFd47YfUH2ahrzDLJl7i68ZfQseJROKUgAsLo886hAv324hkTtjUT46xfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QVgzNjTz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QVgzNjTz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FC751F000E9;
	Fri, 21 Aug 2026 21:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787347044;
	bh=c3REpKxy5hSEi3uTP0B5G0MEOE+lmHStZ74kAZLp1A8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QVgzNjTz8NXgSl0plsTn8E9BSSEc3ZwsEbdoQOhLcy3fox4tXvWJuAQD9OZ6b6ygr
	 QURhKJHVUEPtWq6FtQBw+r4WxBQXxCLxMJD7q5YAvSeyssYbVRJ9yRM4my+zpZ21gb
	 2wDD6cE4pFX6VcRpzxZzrmFhQluVLEDjgu0d4jcMn45mszYwv1Y+Hsjni77zyVkgDD
	 LNu8UmAlYp/cCepTUqjrl4J/fn8nssXNL7rSZZ4ZRjR+CYAQj3lHpB+rXc0kNFPiol
	 P66hmCN0SM3cjKshEruMIB5uAfTJyfKF+XTceJOpdSuG2V+LhQbOHg3iIOGW7MA22s
	 19qpDcbxPtTCQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 10/17] rtc: rzn1: Replace remove callback with
 devm_add_action_or_reset()
Reply-To: sashiko-reviews@lists.linux.dev
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: devicetree@vger.kernel.org, linux-rtc@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, robh@kernel.org, conor+dt@kernel.org, wsa+renesas@sang-engineering.com
In-Reply-To: <20260821211032.13554-11-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260821211032.13554-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260821211032.13554-11-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 21:17:23 +0000
Message-Id: <20260821211724.1FC751F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> Simplify the driver teardown by registering a managed cleanup action with
> devm_add_action_or_reset(). This eliminates the explicit probe error path
> and allows the .remove() callback to be dropped.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821211032.1355=
4-1-prabhakar.mahadev-lad.rj@bp.renesas.com?part=3D10

